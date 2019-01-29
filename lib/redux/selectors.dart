import 'package:hear2learn/helpers/dash.dart' as dash;
import 'package:hear2learn/models/episode.dart';
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
      if(position == null) {
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
    final Episode download = state.downloads != null
      ? dash.find(state.downloads, (Episode download) => download.url == episode.url)
      : null
      ;
    final Episode pendingDownload = state.pendingDownloads != null
      ? dash.find(state.pendingDownloads, (Episode download) => download.url == episode.url)
      : null
      ;
    //final String downloadPath = download?.downloadPath;
    //final double progress = pendingDownload?.progress;
    return download ?? pendingDownload ?? episode;
  };
}
