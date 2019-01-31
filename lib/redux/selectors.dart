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
    return download ?? pendingDownload ?? episode;
  };
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
