import 'dart:async';
import 'dart:convert';

import 'package:hear2learn/app.dart';

class AppSettings {
  bool privacySetting;
  bool skipSilence;
  double speed;
  String themeName;
  bool wifiSetting;

  AppSettings({
    this.privacySetting = false,
    this.skipSilence = false,
    this.speed = 1.0,
    this.themeName = 'Dark',
    this.wifiSetting = false,
  });

  AppSettings.prefs() {
    final App app = App();
    privacySetting = app.prefs.getBool('privacySetting') ?? false;
    skipSilence = app.prefs.getBool('skipSilence') ?? false;
    speed = app.prefs.getDouble('speed') ?? false;
    themeName = app.prefs.getString('themeName') ?? 'Dark';
    wifiSetting = app.prefs.getBool('wifiSetting') ?? false;
  }

  AppSettings copyWith({
    bool privacySetting,
    bool skipSilence,
    double speed,
    String themeName,
    bool wifiSetting,
  }) {
    return AppSettings(
      privacySetting: privacySetting ?? this.privacySetting,
      skipSilence: skipSilence ?? this.skipSilence,
      speed: speed ?? this.speed,
      themeName: themeName ?? this.themeName,
      wifiSetting: wifiSetting ?? this.wifiSetting,
    );
  }

  @override
  String toString() {
    return 'AppSettings[wifiSetting=${wifiSetting.toString()}, skipSilence=${skipSilence.toString()}, speed=${speed.toString()}, privacySetting=${privacySetting.toString()}, themeName=$themeName]';
  }

  AppSettings fromJson(Map<String, dynamic> json) {
    return AppSettings(
      privacySetting: json['privacySetting'],
      skipSilence: json['skipSilence'],
      speed: json['speed'],
      themeName: json['themeName'],
      wifiSetting: json['wifiSetting'],
    );
  }

  String toJson() {
    return jsonEncode(<String, dynamic>{
      'privacySetting': privacySetting,
      'skipSilence': skipSilence,
      'speed': speed,
      'themeName': themeName,
      'wifiSetting': wifiSetting,
    });
  }

  Future<void> persistPreferences() async {
    final App app = App();
    await app.prefs.setBool('privacySetting', privacySetting);
    await app.prefs.setBool('skipSilence', skipSilence);
    await app.prefs.setDouble('speed', speed);
    await app.prefs.setString('themeName', themeName);
    await app.prefs.setBool('wifiSetting', wifiSetting);
  }
}
