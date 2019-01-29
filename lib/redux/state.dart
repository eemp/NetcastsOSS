import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/models/podcast.dart';

class AppState {
  final bool isPlaying;
  final Episode playingEpisode;
  final Duration positionInEpisode;
  final Duration episodeLength;

  final List<Episode> downloads;
  final List<Episode> pendingDownloads;

  final List<Podcast> subscriptions;

  const AppState({
    this.downloads,
    this.episodeLength,
    this.isPlaying = false,
    this.pendingDownloads,
    this.playingEpisode,
    this.positionInEpisode,
    this.subscriptions,
  });

  AppState copyWith({
    List<Episode> downloads,
    Duration episodeLength,
    bool isPlaying,
    List<Episode> pendingDownloads,
    Episode playingEpisode,
    Duration positionInEpisode,
    List<Podcast> subscriptions,
  }) {
    return AppState(
      downloads: downloads ?? this.downloads,
      episodeLength: episodeLength ?? this.episodeLength,
      isPlaying: isPlaying ?? this.isPlaying,
      pendingDownloads: pendingDownloads ?? this.pendingDownloads,
      playingEpisode: playingEpisode ?? this.playingEpisode,
      positionInEpisode: positionInEpisode ?? this.positionInEpisode,
      subscriptions: subscriptions ?? this.subscriptions,
    );
  }
}
