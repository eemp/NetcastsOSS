import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/models/podcast.dart';

class AppState {
  final String playingEpisode;
  final Duration positionInEpisode;

  final List<Podcast> subscriptions;

  Map<String, Episode> userEpisodes;

  AppState({
    this.playingEpisode,
    this.positionInEpisode,
    this.subscriptions,
    this.userEpisodes,
  }) {
    // ignore: prefer_collection_literals
    userEpisodes ??= Map<String, Episode>();
  }

  AppState copyWith({
    String playingEpisode,
    Duration positionInEpisode,
    List<Podcast> subscriptions,
    Map<String, Episode> userEpisodes,
  }) {
    return AppState(
      playingEpisode: playingEpisode ?? this.playingEpisode,
      positionInEpisode: positionInEpisode ?? this.positionInEpisode,
      subscriptions: subscriptions ?? this.subscriptions,
      userEpisodes: userEpisodes ?? this.userEpisodes,
    );
  }
}
