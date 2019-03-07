import 'dart:async';

import 'package:hear2learn/app.dart';
import 'package:hear2learn/models/episode.dart';

class AppSettings {
  // settings
  bool privacySetting;
  bool skipSilence;
  double speed;
  String themeName;
  bool wifiSetting;

  // other prefs
  String currentEpisode;
  String currentPodcast;
  EpisodeQueue episodeQueue;

  AppSettings({
    this.currentEpisode,
    this.currentPodcast,
    this.episodeQueue,
    this.privacySetting = true,
    this.skipSilence = false,
    this.speed = 1.0,
    this.themeName = 'Dark',
    this.wifiSetting = false,
  });

  AppSettings.prefs() {
    final App app = App();
    currentEpisode = app.prefs.getString('currentEpisode');
    currentPodcast = app.prefs.getString('currentPodcast');
    episodeQueue = episodeQueueFromString(app.prefs.getString('episodeQueue'));
    privacySetting = app.prefs.getBool('privacySetting') ?? true;
    skipSilence = app.prefs.getBool('skipSilence') ?? false;
    speed = app.prefs.getDouble('speed') ?? 1.0;
    themeName = app.prefs.getString('themeName') ?? 'Dark';
    wifiSetting = app.prefs.getBool('wifiSetting') ?? false;
  }

  AppSettings copyWith({
    String currentEpisode,
    String currentPodcast,
    EpisodeQueue episodeQueue,
    bool privacySetting,
    bool skipSilence,
    double speed,
    String themeName,
    bool wifiSetting,
  }) {
    return AppSettings(
      currentEpisode: currentEpisode ?? this.currentEpisode,
      currentPodcast: currentPodcast ?? this.currentPodcast,
      episodeQueue: episodeQueue ?? this.episodeQueue,
      privacySetting: privacySetting ?? this.privacySetting,
      skipSilence: skipSilence ?? this.skipSilence,
      speed: speed ?? this.speed,
      themeName: themeName ?? this.themeName,
      wifiSetting: wifiSetting ?? this.wifiSetting,
    );
  }

  @override
  String toString() {
    return 'AppSettings[currentEpisode=$currentEpisode, currentPodcast=$currentPodcast, episodeQueue=${episodeQueue.toString()}, wifiSetting=${wifiSetting.toString()}, skipSilence=${skipSilence.toString()}, speed=${speed.toString()}, privacySetting=${privacySetting.toString()}, themeName=$themeName]';
  }

  Future<void> persistPreferences() async {
    final App app = App();
    await app.prefs.setString('currentEpisode', currentEpisode);
    await app.prefs.setString('currentPodcast', currentPodcast);
    await app.prefs.setString('episodeQueue', episodeQueue.toString());
    await app.prefs.setBool('privacySetting', privacySetting);
    await app.prefs.setBool('skipSilence', skipSilence);
    await app.prefs.setDouble('speed', speed);
    await app.prefs.setString('themeName', themeName);
    await app.prefs.setBool('wifiSetting', wifiSetting);
  }
}
