import 'dart:async';
import 'package:flutter/material.dart';

import 'package:audio_service/audio_service.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dart_chromecast/casting/cast.dart';
import 'package:dart_chromecast/casting/cast_device.dart';
import 'package:hear2learn/app.dart';
import 'package:hear2learn/services/audio.dart';
import 'package:hear2learn/helpers/dash.dart' as dash;
import 'package:hear2learn/helpers/dynamic_theme.dart';
import 'package:hear2learn/helpers/episode.dart' as episode_helpers;
import 'package:hear2learn/helpers/podcast.dart' as podcast_helpers;
import 'package:hear2learn/models/app_settings.dart';
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/models/podcast.dart';
import 'package:hear2learn/redux/selectors.dart';
import 'package:hear2learn/redux/state.dart';
import 'package:hear2learn/widgets/notifications.dart';
import 'package:just_audio/just_audio.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

enum ActionType {
  CLEAR_CAST,
  UPDATE_CAST,

  UPDATE_CONNECTIVITY,

  COMPLETE_EPISODE,
  PAUSE_EPISODE,
  PLAY_EPISODE,
  RESUME_EPISODE,
  SET_EPISODE_LENGTH,
  SET_EPISODE_POSITION,

  DELETE_EPISODE,
  DOWNLOAD_EPISODE,
  FAVORITE_EPISODE,
  FINISH_EPISODE,
  FINISH_DOWNLOADING_EPISODE,
  UPDATE_DOWNLOAD_STATUS,
  UPDATE_DOWNLOADS,
  UPDATE_PENDING_DOWNLOADS,
  UNFAVORITE_EPISODE,
  UNFINISH_EPISODE,

  UPDATE_SUBSCRIPTIONS,

  UPDATE_SETTINGS,
}

class Action {
  final ActionType type;
  final dynamic payload;

  Action({
    this.type,
    this.payload,
  });
}

Future<void> updateConnectivity(Store<AppState> store) async {
  final ConnectivityResult connectivity = await Connectivity().checkConnectivity();
  store.dispatch(
    setConnectivity(connectivity)
  );
}

Action setConnectivity(ConnectivityResult connectivity) {
  return Action(
    type: ActionType.UPDATE_CONNECTIVITY,
    payload: <String, dynamic>{
      'connectivity': connectivity,
    },
  );
}

ThunkAction<AppState> disconnectCast() {
  return (Store<AppState> store) async {
    final CastSender cast = store.state.castSender;
    await cast?.disconnect();
    store.dispatch(Action(
      type: ActionType.CLEAR_CAST,
    ));
  };
}

ThunkAction<AppState> connectToCast(CastDevice device) {
  CastSender cast = CastSender(device);
  return (Store<AppState> store) async {
    final previousCast = store.state.castSender;
    if(previousCast != null) {
      await store.dispatch(disconnectCast());
    }

    bool connected = await cast.connect();
    if(connected) {
      cast.launch();
      store.dispatch(Action(
        type: ActionType.UPDATE_CAST,
        payload: <String, dynamic>{
          'castSender': cast,
        },
      ));
    }
  };
}

ThunkAction<AppState> pauseEpisode(Episode episode) {
  return (Store<AppState> store) async {
    final CastSender castSender = store.state.castSender;

    if(castSender != null) {
      castSender.togglePause();
    }
    else {
      AudioService.pause();
    }

    store.dispatch(Action(
      type: ActionType.PAUSE_EPISODE,
      payload: <String, dynamic>{
        'episode': episode,
      },
    ));
  };
}

ThunkAction<AppState> updateEpisodeLength(episode) {
  return (Store<AppState> store) async {
    AudioPlayer player = AudioPlayer();
    Duration duration = await player.setFilePath(episode.downloadPath);
    store.dispatch(Action(
      type: ActionType.SET_EPISODE_LENGTH,
      payload: <String, dynamic>{
        'length': duration,
      },
    ));
    await player.dispose();
  };
}

ThunkAction<AppState> reflectCastStatus(CastMediaStatus castStatus) {
  final App app = App();
  return (Store<AppState> store) async {
    final Episode currentEpisode = playingEpisodeSelector(store);

    if(castStatus.isFinished) {
      store.dispatch(completeEpisode(currentEpisode));
      return;
    }

    print(castStatus);
    if(castStatus.position != null) {
      store.dispatch(updateEpisodePosition(
        Duration(seconds: castStatus.position.toInt())
      ));
    }
  };
}

ThunkAction<AppState> reflectAudioServiceStatus(PlaybackState playbackState) {
  final App app = App();
  return (Store<AppState> store) async {
    final Episode currentEpisode = playingEpisodeSelector(store);

    if(!AudioService.running) {
      store.dispatch(completeEpisode(currentEpisode));
      return;
    }

    if(playbackState?.currentPosition != null) {
      store.dispatch(updateEpisodePosition(
        Duration(milliseconds: playbackState.currentPosition)
      ));
    }

    final bool shouldUpdateCurrentEpisodeDuration = currentEpisode != null && (
      currentEpisode.length == null || currentEpisode.length.inMilliseconds != AudioService.currentMediaItem?.duration
    );
    if(AudioService.currentMediaItem?.duration != null && shouldUpdateCurrentEpisodeDuration) {
      store.dispatch(Action(
        type: ActionType.SET_EPISODE_LENGTH,
        payload: <String, dynamic>{
          'length': Duration(
            milliseconds: AudioService.currentMediaItem.duration,
          ),
        },
      ));
    }
  };
}

ThunkAction<AppState> playEpisode(Episode episode, { EpisodeQueue episodeQueue }) {
  final App app = App();

  return (Store<AppState> store) async {
    final Episode matchingEpisode = store.state.userEpisodes[episode.url] ?? episode;
    final CastSender castSender = store.state.castSender;
    final Duration position = matchingEpisode.position ?? Duration();

    if(castSender != null) {
      castSender.load(CastMedia(
        contentId: matchingEpisode.url,
        title: matchingEpisode.title,
      ));
      if(matchingEpisode.position != null) {
        castSender.seek(matchingEpisode.position.inSeconds.toDouble());
      }

      // figure out episode length
      store.dispatch(updateEpisodeLength(matchingEpisode));

      castSender.castMediaStatusController.stream.listen((CastMediaStatus castStatus) => (
        store.dispatch(reflectCastStatus(castStatus))
      ));
    }
    else {
      final Function onPlaybackStateUpdateCallback = (playbackState) => (
        store.dispatch(reflectAudioServiceStatus(playbackState))
      );

      await initAudioService(onPlaybackStateUpdateCallback);
      await AudioService.customAction('loadAndPlayMedia', {
        'mediaItem': {
          'album': matchingEpisode.podcastTitle,
          'artist': matchingEpisode.podcastTitle,
          // artwork: matchingEpisode.podcast?.artwork100,
          'path': matchingEpisode.downloadPath,
          'title': matchingEpisode.title,
          //'position': position,
        },
        'position': matchingEpisode.position?.inMilliseconds,
      });
    }

    store.dispatch(Action(
      type: ActionType.PLAY_EPISODE,
      payload: <String, dynamic>{
        'episode': matchingEpisode,
      },
    ));

    if(episodeQueue != null) {
      store.dispatch(queuePlaylist(episodeQueue));
    }
  };
}

ThunkAction<AppState> queuePlaylist(EpisodeQueue episodeQueue) {
  return (Store<AppState> store) async {
    final AppSettings settings = store.state.settings;
    final Episode currentEpisode = playingEpisodeSelector(store);
    store.dispatch(
      updateSettings(settings.copyWith(
        currentEpisode: currentEpisode.url,
        currentPodcast: episodeQueue == EpisodeQueue.PODCAST
          ? currentEpisode.podcastUrl
          : null,
        episodeQueue: episodeQueue,
      ))
    );
  };
}

ThunkAction<AppState> resumeEpisode() {
  return (Store<AppState> store) async {
    final App app = App();
    final CastSender castSender = store.state.castSender;

    if(castSender != null) {
      castSender.togglePause();
    }
    else {
      AudioService.play();
    }

    store.dispatch(Action(
      type: ActionType.RESUME_EPISODE,
    ));
  };
}

ThunkAction<AppState> seekInEpisode(Duration position) {
  return (Store<AppState> store) async {
    final App app = App();
    final CastSender castSender = store.state.castSender;

    if(castSender != null) {
      castSender.seek(position.inSeconds.toDouble());
    }
    else {
      AudioService.seekTo(position.inMilliseconds);
    }

    return setEpisodePosition(
      position > const Duration(seconds: 0)
        ? position
        : const Duration(seconds: 0)
    );
  };
}

ThunkAction<AppState> updateEpisodePosition(Duration position) {
  return (Store<AppState> store) async {
    final Episode playingEpisode = playingEpisodeSelector(store);
    if(playingEpisode != null && position.inSeconds % 5 == 0) {
      await episode_helpers.updateEpisodePosition(playingEpisode, position);
      if(!playingEpisode.isFinished && playingEpisode.isPlayedToEnd()) {
        store.dispatch(finishEpisode(playingEpisode));
      }
    }
    store.dispatch(setEpisodePosition(position));
  };
}

Action setEpisodePosition(Duration position) {
  return Action(
    type: ActionType.SET_EPISODE_POSITION,
    payload: <String, dynamic>{
      'position': position,
    },
  );
}

ThunkAction<AppState> batchFavorite(List<Episode> episodes) {
  return (Store<AppState> store) async {
    for(Episode episode in episodes) {
      store.dispatch(favoriteEpisode(episode));
    }
  };
}

ThunkAction<AppState> favoriteEpisode(Episode episode) {
  return (Store<AppState> store) async {
    await episode_helpers.favoriteEpisode(episode);
    store.dispatch(Action(
      type: ActionType.FAVORITE_EPISODE,
      payload: <String, dynamic>{
        'episode': episode,
      },
    ));
  };
}

ThunkAction<AppState> batchUnfavorite(List<Episode> episodes) {
  return (Store<AppState> store) async {
    for(Episode episode in episodes) {
      store.dispatch(unfavoriteEpisode(episode));
    }
  };
}

ThunkAction<AppState> unfavoriteEpisode(Episode episode) {
  return (Store<AppState> store) async {
    await episode_helpers.unfavoriteEpisode(episode);
    store.dispatch(Action(
      type: ActionType.UNFAVORITE_EPISODE,
      payload: <String, dynamic>{
        'episode': episode,
      },
    ));
  };
}

ThunkAction<AppState> batchFinish(List<Episode> episodes) {
  return (Store<AppState> store) async {
    for(Episode episode in episodes) {
      store.dispatch(finishEpisode(episode));
    }
  };
}

ThunkAction<AppState> finishEpisode(Episode episode) {
  return (Store<AppState> store) async {
    await episode_helpers.finishEpisode(episode);
    store.dispatch(Action(
      type: ActionType.FINISH_EPISODE,
      payload: <String, dynamic>{
        'episode': episode,
      },
    ));
    setEpisodePosition(Duration.zero);
  };
}

ThunkAction<AppState> batchUnfinish(List<Episode> episodes) {
  return (Store<AppState> store) async {
    for(Episode episode in episodes) {
      store.dispatch(unfinishEpisode(episode));
    }
  };
}

ThunkAction<AppState> unfinishEpisode(Episode episode) {
  return (Store<AppState> store) async {
    await episode_helpers.unfinishEpisode(episode);
    store.dispatch(Action(
      type: ActionType.UNFINISH_EPISODE,
      payload: <String, dynamic>{
        'episode': episode,
      },
    ));
  };
}

ThunkAction<AppState> subscribeToPodcast(Podcast podcast) {
  return (Store<AppState> store) async {
    await podcast_helpers.subscribeToPodcast(podcast);
    store.dispatch(updateSubscriptions);
  };
}

ThunkAction<AppState> unsubscribeFromPodcast(Podcast podcast) {
  return (Store<AppState> store) async {
    await podcast_helpers.unsubscribeFromPodcast(podcast);
    store.dispatch(updateSubscriptions);
  };
}


Future<void> updateSubscriptions(Store<AppState> store) async {
  final List<Podcast> subscriptions = await podcast_helpers.getSubscriptions();
  store.dispatch(
    setSubscriptions(subscriptions)
  );
}

Action setSubscriptions(List<Podcast> subscriptions) {
  return Action(
    type: ActionType.UPDATE_SUBSCRIPTIONS,
    payload: <String, dynamic>{
      'subscriptions': subscriptions,
    },
  );
}

Future<void> updateDownloads(Store<AppState> store) async {
  final List<Episode> downloads = await episode_helpers.getDownloads();
  store.dispatch(
    setDownloads(downloads)
  );
}

Action setDownloads(List<Episode> downloads) {
  return Action(
    type: ActionType.UPDATE_DOWNLOADS,
    payload: <String, dynamic>{
      'downloads': downloads,
    },
  );
}

ThunkAction<AppState> completeEpisode([Episode episode]) {
  final App app = App();

  return (Store<AppState> store) async {
    final Episode playingEpisode = store.state.userEpisodes[store.state.playingEpisode];
    episode ??= playingEpisode;
    if(episode != null && episode.url == playingEpisode?.url) {
      store.dispatch(Action(
        type: ActionType.COMPLETE_EPISODE,
      ));
      store.dispatch(playNextEpisodeInQueue());
    }
  };
}

ThunkAction<AppState> playNextEpisodeInQueue() {
  return (Store<AppState> store) async {
    final EpisodeQueue episodeQueue = store.state.settings.episodeQueue;
    final List<Episode> queuedEpisodes = queueSelector(store);
    if(queuedEpisodes.isNotEmpty) {
      store.dispatch(playEpisode(queuedEpisodes[0], episodeQueue: episodeQueue));
    }
  };
}

ThunkAction<AppState> batchDelete(List<Episode> episodes, { BuildContext context }) {
  return (Store<AppState> store) async {
    for(Episode episode in episodes) {
      store.dispatch(deleteEpisode(episode));
    }

    showBatchEpisodeDeleteNotification(context, episodes);
  };
}

ThunkAction<AppState> deleteEpisode(Episode episode, { BuildContext context }) {
  return (Store<AppState> store) async {
    if(episode.url == store.state.playingEpisode) {
      store.dispatch(completeEpisode(episode));
    }

    await episode_helpers.deleteEpisode(episode);
    store.dispatch(removeEpisode(episode));

    showEpisodeDeleteNotification(context, episode);
  };
}

Action removeEpisode(Episode episode) {
  return Action(
    type: ActionType.DELETE_EPISODE,
    payload: <String, dynamic>{
      'episode': episode,
    },
  );
}

ThunkAction<AppState> batchDownload(List<Episode> episodes, { BuildContext context }) {
  return (Store<AppState> store) async {
    final bool connectivityIsAvailable = connectivityCheck(store.state.connectivity, store.state.settings, context: context);
    if(!connectivityIsAvailable) {
      return;
    }

    for(Episode episode in episodes) {
      store.dispatch(downloadEpisode(episode, context: context));
    }
  };
}

ThunkAction<AppState> downloadEpisode(Episode episode, { BuildContext context }) {
  return (Store<AppState> store) async {
    final bool connectivityIsAvailable = connectivityCheck(store.state.connectivity, store.state.settings, context: context);
    if(!connectivityIsAvailable) {
      return;
    }

    store.dispatch(queueDownload(episode));

    final Function throttledStatusUpdate = dash.throttle(
      (EpisodeStatus status, double progress) {
        if(status == EpisodeStatus.DOWNLOADING) {
          store.dispatch(updateDownloadStatus(episode, progress));
        }
        else {
          store.dispatch(finishDownloadingEpisode(episode));
        }
      },
      const Duration(milliseconds: 1000)
    );

    await episode_helpers.downloadEpisode(episode, onProgress: (int received, int total) {
      final List<dynamic> throttledUpdateArgs = <dynamic>[ EpisodeStatus.DOWNLOADING, received/total ];
      throttledStatusUpdate(throttledUpdateArgs);
    });

    final List<dynamic> throttledUpdateArgs = <dynamic>[ EpisodeStatus.DOWNLOADED, 1.0 ];
    throttledStatusUpdate(throttledUpdateArgs);
  };
}

bool connectivityCheck(ConnectivityResult currentConnectivity, AppSettings settings, { BuildContext context }) {
  if(currentConnectivity == ConnectivityResult.none) {
    showNoConnectivityNotification(context);
    return false;
  }
  else if(settings.wifiSetting && currentConnectivity != ConnectivityResult.wifi) {
    showNoWifiNotification(context);
    return false;
  }
  return true;
}

Action queueDownload(Episode download) {
  return Action(
    type: ActionType.DOWNLOAD_EPISODE,
    payload: <String, dynamic>{
      'episode': download,
    },
  );
}

Action updateDownloadStatus(Episode episode, double progress) {
  return Action(
    type: ActionType.UPDATE_DOWNLOAD_STATUS,
    payload: <String, dynamic>{
      'episode': episode,
      'progress': progress,
    },
  );
}

Action finishDownloadingEpisode(Episode episode) {
  return Action(
    type: ActionType.FINISH_DOWNLOADING_EPISODE,
    payload: <String, dynamic>{
      'episode': episode,
    },
  );
}

void loadSettings(Store<AppState> store) {
  final AppSettings settings = AppSettings.prefs();
  store.dispatch(
    setSettings(settings)
  );
  if(settings.currentEpisode != null) {
    store.dispatch(Action(
      type: ActionType.PLAY_EPISODE,
      payload: <String, dynamic>{
        'episodeUrl': settings.currentEpisode,
      },
    ));
  }
}

ThunkAction<AppState> updateSettings(AppSettings settings, { BuildContext context }) {
  return (Store<AppState> store) async {
    onAppSettingsUpdate(settings, context: context);
    await settings.persistPreferences();
    store.dispatch(setSettings(settings));
  };
}

void onAppSettingsUpdate(AppSettings newSettings, { BuildContext context }) {
  final App app = App();
  //app.player.setOptions(
    //skipSilence: newSettings.skipSilence ?? false,
    //speed: newSettings.speed ?? 1.0,
  //);
  if(context != null) {
    DynamicTheme.of(context).setTheme(newSettings.themeName);
  }
}

Action setSettings(AppSettings settings) {
  return Action(
    type: ActionType.UPDATE_SETTINGS,
    payload: <String, dynamic>{
      'settings': settings,
    },
  );
}
