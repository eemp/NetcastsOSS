import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/models/podcast.dart';

class AppState {
  final String playingEpisode;
  final Duration positionInEpisode;

  final Map<String, Episode> userEpisodes;

  final List<Podcast> subscriptions;

  AppState({
    this.playingEpisode,
    this.positionInEpisode,
    this.subscriptions,
    // ignore: prefer_collection_literals, non_constant_default_value
    this.userEpisodes = Map<String, Episode>(),
  });

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
