import 'package:hear2learn/helpers/dash.dart' as dash;
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/models/podcast.dart';
import 'package:hear2learn/models/queued_episode.dart';
import 'package:hear2learn/redux/actions.dart';
import 'package:hear2learn/redux/state.dart';
import 'package:redux/redux.dart';

QueuedEpisode queuedEpisodeSelector(Store<AppState> store) {
  return QueuedEpisode(
    episode: store.state.playingEpisode,
    onPause: (Episode episode) {
      store.dispatch(pauseEpisode(episode));
    },
    onPlay: (Episode episode) {
      final Duration position = store.state.playingEpisode?.position;
      if(position == null || store.state.playingEpisode?.url != episode.url) {
        store.dispatch(playEpisode(episode));
      }
      else {
        store.dispatch(resumeEpisode());
      }
    },
  );
}

Function getEpisodeSelector(Episode episode) {
  return (Store<AppState> store) {
    final AppState state = store.state;
    final Episode userEpisode = state.userEpisodes[episode.url];

    final Episode selectedEpisode = userEpisode ?? episode;
    selectedEpisode.status = isPlayedToEnd(store, selectedEpisode)
      ?? isPaused(store, selectedEpisode)
      ?? isPlaying(store, selectedEpisode)
      ?? isDownloaded(store, selectedEpisode)
      ?? isDownloading(store, selectedEpisode)
      ?? defaultStatus(store, selectedEpisode)
      ;

    if(selectedEpisode.status == EpisodeStatus.PAUSED || selectedEpisode.status == EpisodeStatus.PLAYING) {
      selectedEpisode.length = state.playingEpisode.length;
      selectedEpisode.position = state.playingEpisode.position;
    }

    return selectedEpisode;
  };
}

EpisodeStatus isPlayedToEnd(Store<AppState> store, Episode episode) {
  final AppState state = store.state;
  return (state.playingEpisode?.url != episode.url || state.playingEpisode?.status != EpisodeStatus.PLAYING) && episode.isPlayedToEnd() && episode.downloadPath != null
    ? EpisodeStatus.PLAYED
    : null;
}

EpisodeStatus isPaused(Store<AppState> store, Episode episode) {
  final AppState state = store.state;
  return (state.playingEpisode?.url == episode.url && state.playingEpisode?.status != EpisodeStatus.PLAYING)
    ? EpisodeStatus.PAUSED
    : null;
}

EpisodeStatus isPlaying(Store<AppState> store, Episode episode) {
  final AppState state = store.state;
  return (state.playingEpisode?.url == episode.url && state.playingEpisode?.status == EpisodeStatus.PLAYING)
    ? EpisodeStatus.PLAYING
    : null;
}

EpisodeStatus isDownloaded(Store<AppState> store, Episode episode) {
  return (episode.downloadPath != null)
    ? EpisodeStatus.DOWNLOADED
    : null;
}

EpisodeStatus isDownloading(Store<AppState> store, Episode episode) {
  return (episode.progress != null)
    ? EpisodeStatus.DOWNLOADING
    : null;
}

EpisodeStatus defaultStatus(Store<AppState> store, Episode episode) {
  return EpisodeStatus.NONE;
}

List<Episode> downloadsSelector(Store<AppState> store) {
  return store.state.userEpisodes.values.where((Episode episode) => episode.downloadPath != null).toList();
}

List<Podcast> subscriptionsSelector(Store<AppState> store) {
  return store.state.subscriptions;
}

Function getSubscriptionSelector(Podcast potentialSubscription) {
  return (Store<AppState> store) {
    final AppState state = store.state;
    return dash.find(state.subscriptions, (Podcast podcast) => podcast.feed == potentialSubscription.feed);
  };
}
