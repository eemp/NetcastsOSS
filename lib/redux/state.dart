import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/models/podcast.dart';

class AppState {
  final bool isPlaying;
  final Episode playingEpisode;
  final Duration positionInEpisode;
  final Duration episodeLength;
  final List<Podcast> subscriptions;

  const AppState({
    this.episodeLength,
    this.isPlaying = false,
    this.playingEpisode,
    this.positionInEpisode,
    this.subscriptions,
  });

  AppState copyWith({
    Duration episodeLength,
    bool isPlaying,
    Episode playingEpisode,
    Duration positionInEpisode,
    List<Podcast> subscriptions,
  }) {
    return AppState(
      episodeLength: episodeLength ?? this.episodeLength,
      isPlaying: isPlaying ?? this.isPlaying,
      playingEpisode: playingEpisode ?? this.playingEpisode,
      positionInEpisode: positionInEpisode ?? this.positionInEpisode,
      subscriptions: subscriptions ?? this.subscriptions,
    );
  }
}
