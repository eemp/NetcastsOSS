import 'dart:async';
import 'dart:convert';

import 'package:hear2learn/app.dart';

class AppSettings {
  bool privacySetting;
  String themeName;
  bool wifiSetting;

  AppSettings({
    this.privacySetting = false,
    this.themeName = 'Dark',
    this.wifiSetting = false,
  });

  AppSettings.prefs() {
    final App app = App();
    privacySetting = app.prefs.getBool('privacySetting') ?? false;
    themeName = app.prefs.getString('themeName') ?? 'Dark';
    wifiSetting = app.prefs.getBool('wifiSetting') ?? false;
  }

  AppSettings copyWith({
    bool privacySetting,
    String themeName,
    bool wifiSetting,
  }) {
    return AppSettings(
      privacySetting: privacySetting ?? this.privacySetting,
      themeName: themeName ?? this.themeName,
      wifiSetting: wifiSetting ?? this.wifiSetting,
    );
  }

  @override
  String toString() {
    return 'AppSettings[wifiSetting=${wifiSetting.toString()}, privacySetting=${privacySetting.toString()}, themeName=$themeName]';
  }

  AppSettings fromJson(Map<String, dynamic> json) {
    return AppSettings(
      privacySetting: json['privacySetting'],
      themeName: json['themeName'],
      wifiSetting: json['wifiSetting'],
    );
  }

  String toJson() {
    return jsonEncode(<String, dynamic>{
      'wifiSetting': wifiSetting,
      'privacySetting': privacySetting,
      'themeName': themeName,
    });
  }

  Future<void> persistPreferences() async {
    final App app = App();
    await app.prefs.setBool('privacySetting', privacySetting);
    await app.prefs.setString('themeName', themeName);
    await app.prefs.setBool('wifiSetting', wifiSetting);
  }
}
