import 'package:flutter/material.dart';

class ThemeProvider {
  static const String BLUES_THEME = 'Blues';
  static final ThemeData bluesThemeData = ThemeData(
    accentColor: const Color(0xFF005B96),
    primaryColor: const Color(0xFF6497B1),
    brightness: Brightness.light,
    fontFamily: 'OpenSans',
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

  static const String MONOKAI_THEME = 'Monokai';
  static final ThemeData monokaiThemeData = ThemeData(
    accentColor: const Color(0xFF66D9EF),
    brightness: Brightness.dark,
    canvasColor: const Color(0xFF272822),
    cardColor: const Color(0xFF272822),
    cursorColor: const Color(0xFF66D9EF),
    errorColor: const Color(0xFF90274A),
    fontFamily: 'OpenSans',
    highlightColor: const Color(0xFFAE81FF),
    hintColor: const Color(0xFFAE81FF),
    indicatorColor: const Color(0xFFAE81FF),
    primaryColor: const Color(0xFFF92672),
    primaryColorBrightness: Brightness.dark,
    toggleableActiveColor: const Color(0xFF065CBE),
  );

  static final Map<String, ThemeData> themes = <String, ThemeData>{};

  static const List<String> THEME_LIST = <String>[
    BLUES_THEME,
    DARK_THEME,
    LIGHT_THEME,
    MONOKAI_THEME,
  ];

  static const String DEFAULT_THEME = DARK_THEME;

  ThemeData call(String themeName) {
    themes[BLUES_THEME] = bluesThemeData;
    themes[DARK_THEME] = darkThemeData;
    themes[LIGHT_THEME] = lightThemeData;
    themes[MONOKAI_THEME] = monokaiThemeData;
    return themes[themeName];
  }
}
