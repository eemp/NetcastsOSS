import 'package:connectivity/connectivity.dart';
import 'package:dart_chromecast/casting/cast.dart';
import 'package:hear2learn/models/app_settings.dart';
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/models/podcast.dart';

class AppState {
  final CastSender castSender;
  final ConnectivityResult connectivity;
  final String playingEpisode;
  AppSettings settings;
  final List<Podcast> subscriptions;
  Map<String, Episode> userEpisodes;

  AppState({
    this.castSender,
    this.connectivity,
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
    CastSender castSender,
    ConnectivityResult connectivity,
    String playingEpisode,
    AppSettings settings,
    List<Podcast> subscriptions,
    Map<String, Episode> userEpisodes,
  }) {
    return AppState(
      castSender: castSender ?? this.castSender,
      connectivity: connectivity ?? this.connectivity,
      playingEpisode: playingEpisode ?? this.playingEpisode,
      settings: settings ?? this.settings,
      subscriptions: subscriptions ?? this.subscriptions,
      userEpisodes: userEpisodes ?? this.userEpisodes,
    );
  }
}
