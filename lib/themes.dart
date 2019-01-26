import 'package:flutter/material.dart';

class ThemeProvider {
  static const String BEACH_THEME = 'Beach';
  static final ThemeData beachThemeData = ThemeData(
    accentColor: const Color(0xFFFE4A49),
    brightness: Brightness.light,
    fontFamily: 'OpenSans',
    primaryColor: const Color(0xFF2AB7CA),
  );

  static const String BLUES_THEME = 'Blues';
  static final ThemeData bluesThemeData = ThemeData(
    accentColor: const Color(0xFFB3CDE0),
    brightness: Brightness.light,
    fontFamily: 'OpenSans',
    primaryColor: const Color(0xFF005B96),
  );

  static const String DARK_THEME = 'Dark';
  static final ThemeData darkThemeData = ThemeData(
    accentColor: Colors.pink[700],
    brightness: Brightness.dark,
    fontFamily: 'OpenSans',
    primaryColor: Colors.blueGrey[500],
  );

  static const String LIGHT_THEME = 'Light';
  static final ThemeData lightThemeData = ThemeData(
    accentColor: Colors.pink[700],
    brightness: Brightness.light,
    fontFamily: 'OpenSans',
    primaryColor: Colors.blueGrey[500],
  );

  static final Map<String, ThemeData> themes = <String, ThemeData>{};

  static const List<String> THEME_LIST = <String>[
    BEACH_THEME,
    BLUES_THEME,
    DARK_THEME,
    LIGHT_THEME,
  ];

  static const String DEFAULT_THEME = 'Dark';

  ThemeData call(String themeName) {
    themes[BEACH_THEME] = beachThemeData;
    themes[BLUES_THEME] = bluesThemeData;
    themes[DARK_THEME] = darkThemeData;
    themes[LIGHT_THEME] = lightThemeData;
    return themes[themeName];
  }
}
