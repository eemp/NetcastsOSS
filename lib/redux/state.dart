import 'package:hear2learn/models/app_settings.dart';
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/models/podcast.dart';

class AppState {
  final String playingEpisode;
  AppSettings settings;
  final List<Podcast> subscriptions;
  Map<String, Episode> userEpisodes;

  AppState({
    this.playingEpisode,
    this.settings,
    this.subscriptions,
    this.userEpisodes,
  }) {
    settings ??= AppSettings();
    // ignore: prefer_collection_literals
    userEpisodes ??= Map<String, Episode>();
  }

  AppState copyWith({
    String playingEpisode,
    AppSettings settings,
    List<Podcast> subscriptions,
    Map<String, Episode> userEpisodes,
  }) {
    return AppState(
      playingEpisode: playingEpisode ?? this.playingEpisode,
      settings: settings ?? this.settings,
      subscriptions: subscriptions ?? this.subscriptions,
      userEpisodes: userEpisodes ?? this.userEpisodes,
    );
  }
}
