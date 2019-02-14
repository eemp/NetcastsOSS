import 'package:flutter/material.dart';

class ThemeProvider {
  static const String BLUES_THEME = 'Blues';
  static final ThemeData bluesThemeData = ThemeData(
    primaryColor: const Color(0xFF6497B1),
    brightness: Brightness.light,
    fontFamily: 'OpenSans',
    accentColor: const Color(0xFF005B96),
  );

  static const String DARK_THEME = 'Dark';
  static final ThemeData darkThemeData = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'OpenSans',
  );

  static const String LIGHT_THEME = 'Light';
  static final ThemeData lightThemeData = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'OpenSans',
  );

  static final Map<String, ThemeData> themes = <String, ThemeData>{};

  static const List<String> THEME_LIST = <String>[
    BLUES_THEME,
    DARK_THEME,
    LIGHT_THEME,
  ];

  static const String DEFAULT_THEME = 'Dark';

  ThemeData call(String themeName) {
    themes[BLUES_THEME] = bluesThemeData;
    themes[DARK_THEME] = darkThemeData;
    themes[LIGHT_THEME] = lightThemeData;
    return themes[themeName];
  }
}
