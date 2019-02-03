import 'package:hear2learn/helpers/dash.dart' as dash;
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/models/podcast.dart';
import 'package:hear2learn/models/queued_episode.dart';
import 'package:hear2learn/redux/actions.dart';
import 'package:hear2learn/redux/state.dart';
import 'package:redux/redux.dart';

QueuedEpisode queuedEpisodeSelector(Store<AppState> store) {
  return QueuedEpisode(
    duration: store.state.episodeLength,
    episode: store.state.playingEpisode,
    isPlaying: store.state.isPlaying,
    position: store.state.positionInEpisode,
    onPause: () {
      store.dispatch(pauseEpisode());
    },
    onPlay: (Episode episode) {
      final Duration position = store.state.positionInEpisode;
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
    final Episode download = dash.find(state.downloads, (Episode download) => download.url == episode.url);
    final Episode pendingDownload = dash.find(state.pendingDownloads, (Episode download) => download.url == episode.url);

    final Episode selectedEpisode = download ?? pendingDownload ?? episode;
    selectedEpisode.status = isPaused(store, selectedEpisode)
      ?? isPlaying(store, selectedEpisode)
      ?? isDownloaded(store, selectedEpisode)
      ?? isDownloading(store, selectedEpisode)
      ?? defaultStatus(store, selectedEpisode)
      ;

    if(selectedEpisode.status == EpisodeStatus.PAUSED || selectedEpisode.status == EpisodeStatus.PLAYING) {
      selectedEpisode.length = state.episodeLength;
      selectedEpisode.position = state.positionInEpisode;
    }

    return selectedEpisode;
  };
}

EpisodeStatus isPaused(Store<AppState> store, Episode episode) {
  final AppState state = store.state;
  return (state.playingEpisode?.url == episode.url && !state.isPlaying)
    ? EpisodeStatus.PAUSED
    : null;
}

EpisodeStatus isPlaying(Store<AppState> store, Episode episode) {
  final AppState state = store.state;
  return (state.playingEpisode?.url == episode.url && state.isPlaying)
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
  return store.state.downloads;
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
