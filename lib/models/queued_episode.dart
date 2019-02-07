import 'package:hear2learn/models/episode.dart';

class QueuedEpisode {
  final Duration duration;
  final Episode episode;
  final Function onPause;
  final Function onPlay;

  QueuedEpisode({
    this.duration,
    this.episode,
    this.onPause,
    this.onPlay,
  });
}
