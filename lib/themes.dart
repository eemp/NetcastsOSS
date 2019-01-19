import 'package:flutter/material.dart';

class ThemeProvider {
  static final String BEACH_THEME = 'Beach';
  static final ThemeData BEACH_THEME_DATA = ThemeData(
    accentColor: Color(0xFFFE4A49),
    brightness: Brightness.light,
    fontFamily: 'OpenSans',
    primaryColor: Color(0xFF2AB7CA),
  );

  static final String BLUES_THEME = 'Blues';
  static final ThemeData BLUES_THEME_DATA = ThemeData(
    accentColor: Color(0xFFB3CDE0),
    brightness: Brightness.light,
    fontFamily: 'OpenSans',
    primaryColor: Color(0xFF005B96),
  );

  static final String DARK_THEME = 'Dark';
  static final ThemeData DARK_THEME_DATA = ThemeData(
    accentColor: Colors.pink[700],
    brightness: Brightness.dark,
    fontFamily: 'OpenSans',
    primaryColor: Colors.blueGrey[500],
  );

  static final String LIGHT_THEME = 'Light';
  static final ThemeData LIGHT_THEME_DATA = ThemeData(
    accentColor: Colors.pink[700],
    brightness: Brightness.light,
    fontFamily: 'OpenSans',
    primaryColor: Colors.blueGrey[500],
  );

  static final Map<String, ThemeData> THEMES = new Map<String, ThemeData>();

  static final List<String> THEME_LIST = [
    BEACH_THEME,
    BLUES_THEME,
    DARK_THEME,
    LIGHT_THEME,
  ];

  static final String DEFAULT_THEME = 'Dark';

  ThemeData call(String themeName) {
    THEMES[BEACH_THEME] = BEACH_THEME_DATA;
    THEMES[BLUES_THEME] = BLUES_THEME_DATA;
    THEMES[DARK_THEME] = DARK_THEME_DATA;
    THEMES[LIGHT_THEME] = LIGHT_THEME_DATA;
    return THEMES[themeName];
  }
}
