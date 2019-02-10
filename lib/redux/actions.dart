import 'dart:async';
import 'package:hear2learn/app.dart';
import 'package:hear2learn/helpers/dash.dart' as dash;
import 'package:hear2learn/helpers/episode.dart' as episode_helpers;
import 'package:hear2learn/helpers/podcast.dart' as podcast_helpers;
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/models/podcast.dart';
import 'package:hear2learn/redux/state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

const String PAUSE_BUTTON = '⏸️';
const String PLAY_BUTTON = '▶️';

enum ActionType {
  CLEAR_EPISODE,
  PAUSE_EPISODE,
  PLAY_EPISODE,
  RESUME_EPISODE,
  SET_EPISODE_LENGTH,
  SET_EPISODE_POSITION,

  DELETE_EPISODE,
  DOWNLOAD_EPISODE,
  FINISH_DOWNLOADING_EPISODE,
  UPDATE_DOWNLOAD_STATUS,
  UPDATE_DOWNLOADS,
  UPDATE_PENDING_DOWNLOADS,

  UPDATE_SUBSCRIPTIONS,
}

class Action {
  final ActionType type;
  final dynamic payload;

  Action({
    this.type,
    this.payload,
  });
}

ThunkAction<AppState> pauseEpisode(Episode episode) {
  return (Store<AppState> store) async {
    final App app = App();

    app.player.pause();
    await app.createNotification(
      actionText: '$PLAY_BUTTON Resume',
      callback: (String payload) {
        store.dispatch(resumeEpisode());
      },
      content: getPlayingEpisode(store).title,
      payload: 'playAction',
      title: getPlayingEpisode(store).podcastTitle,
    );

    store.dispatch(Action(
      type: ActionType.PAUSE_EPISODE,
      payload: <String, dynamic>{
        'episode': episode,
      },
    ));
  };
}

ThunkAction<AppState> playEpisode(Episode episode) {
  return (Store<AppState> store) async {
    final App app = App();
    final Episode matchingEpisode = store.state.userEpisodes[episode.url] ?? episode;

    app.player.play(
      matchingEpisode.downloadPath,
      isLocal: true,
    );
    app.player.seek(matchingEpisode.position ?? Duration());

    await app.createNotification(
      actionText: '$PAUSE_BUTTON Pause',
      callback: (String payload) {
        store.dispatch(pauseEpisode(matchingEpisode));
      },
      content: matchingEpisode.title,
      isOngoing: true,
      payload: 'pauseAction',
      title: matchingEpisode.podcastTitle,
    );

    store.dispatch(Action(
      type: ActionType.PLAY_EPISODE,
      payload: <String, dynamic>{
        'episode': matchingEpisode,
      },
    ));
  };
}

ThunkAction<AppState> resumeEpisode() {
  return (Store<AppState> store) async {
    final App app = App();

    app.player.resume();
    await app.createNotification(
      actionText: '$PAUSE_BUTTON Pause',
      callback: (String payload) {
        store.dispatch(pauseEpisode(getPlayingEpisode(store)));
      },
      content: getPlayingEpisode(store).title,
      isOngoing: true,
      payload: 'pauseAction',
      title: getPlayingEpisode(store).podcastTitle,
    );

    store.dispatch(Action(
      type: ActionType.RESUME_EPISODE,
    ));
  };
}

Action seekInEpisode(Duration position) {
  final App app = App();

  app.player.seek(position);
  return setEpisodePosition(position);
}

ThunkAction<AppState> updateEpisodePosition(Duration position) {
  return (Store<AppState> store) async {
    if(position.inSeconds % 5 == 0) {
      await episode_helpers.updateEpisodePosition(getPlayingEpisode(store), position);
    }
    store.dispatch(setEpisodePosition(position));
  };
}

Episode getPlayingEpisode(Store<AppState> store) {
  final String playingEpisode = store.state.playingEpisode;
  final Map<String, Episode> userEpisodes = store.state.userEpisodes;
  return dash.isNotEmpty(playingEpisode)
    ? userEpisodes[playingEpisode]
    : null;
}

Action setEpisodePosition(Duration position) {
  return Action(
    type: ActionType.SET_EPISODE_POSITION,
    payload: <String, dynamic>{
      'position': position,
    },
  );
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

ThunkAction<AppState> deleteEpisode(Episode episode) {
  return (Store<AppState> store) async {
    final App app = App();
    if(episode.url == store.state.playingEpisode) {
      app.player.pause();
    }

    await episode_helpers.deleteEpisode(episode);
    store.dispatch(removeEpisode(episode));
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

ThunkAction<AppState> downloadEpisode(Episode episode) {
  return (Store<AppState> store) async {
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
      Duration(milliseconds: 1000)
    );

    await episode_helpers.downloadEpisode(episode, onProgress: (int received, int total) {
      final List<dynamic> throttledUpdateArgs = <dynamic>[ EpisodeStatus.DOWNLOADING, received/total ];
      throttledStatusUpdate(throttledUpdateArgs);
    });

    final List<dynamic> throttledUpdateArgs = <dynamic>[ EpisodeStatus.DOWNLOADED, 1.0 ];
    throttledStatusUpdate(throttledUpdateArgs);
  };
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
