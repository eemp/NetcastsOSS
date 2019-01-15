import 'package:flutter_redux/flutter_redux.dart';
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
    onPlay: (episode) {
      Duration position = store.state.positionInEpisode;
      if(position == null) {
        store.dispatch(playEpisode(episode));
      }
      else {
        store.dispatch(resumeEpisode());
      }
    },
  );
}
