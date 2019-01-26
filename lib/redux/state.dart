import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/models/podcast.dart';

class AppState {
  bool isPlaying;
  Episode playingEpisode;
  Duration positionInEpisode;
  Duration episodeLength;
  List<Podcast> subscriptions;

  AppState({
    this.episodeLength = null,
    this.isPlaying = false,
    this.playingEpisode = null,
    this.positionInEpisode = null,
    this.subscriptions = null,
  });

  AppState copyWith({Duration episodeLength, bool isPlaying, Episode playingEpisode}) {
    return AppState(
      episodeLength: episodeLength ?? this.episodeLength,
      isPlaying: isPlaying ?? this.isPlaying,
      playingEpisode: playingEpisode ?? this.playingEpisode,
      positionInEpisode: positionInEpisode ?? this.positionInEpisode,
      subscriptions: subscriptions ?? this.subscriptions,
    );
  }
}
