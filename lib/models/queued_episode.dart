import 'package:hear2learn/models/episode.dart';

class QueuedEpisode {
  final Duration duration;
  final Episode episode;
  final bool isPlaying;
  final Function onPause;
  final Function onPlay;
  final Duration position;

  QueuedEpisode({
    this.duration,
    this.episode,
    this.isPlaying,
    this.onPause,
    this.onPlay,
    this.position,
  });
}
