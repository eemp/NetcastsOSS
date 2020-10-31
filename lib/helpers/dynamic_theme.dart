import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef Widget ThemedWidgetBuilder(BuildContext context, ThemeData data);

typedef ThemeData ThemeDataBuilder(String themeName);

class DynamicTheme extends StatefulWidget {
  final ThemeData defaultTheme;
  final String defaultThemeName;
  final ThemeDataBuilder themeBuilder;
  final ThemedWidgetBuilder widgetBuilder;

  const DynamicTheme({
    Key key,
    this.defaultTheme,
    this.defaultThemeName,
    this.themeBuilder,
    this.widgetBuilder,
  }) : super(key: key);

  @override
  DynamicThemeState createState() => new DynamicThemeState();

  static DynamicThemeState of(BuildContext context) {
    return context.ancestorStateOfType(const TypeMatcher<DynamicThemeState>());
  }
}

class DynamicThemeState extends State<DynamicTheme> {
  static const String sharedPreferencesKey = "theme";

  ThemeData theme;
  String themeName;

  get defaultTheme => widget.defaultTheme;
  get defaultThemeName => widget.defaultThemeName;
  get themeBuilder => widget.themeBuilder;
  get widgetBuilder => widget.widgetBuilder;

  @override
  void initState() {
    super.initState();

    themeName = defaultThemeName;
    theme = themeBuilder(defaultThemeName);

    loadThemePreference().then((savedThemeName) {
      setState(() {
        if(savedThemeName != null) {
          themeName = savedThemeName;
          theme = themeBuilder(themeName);
        }
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme = widget.themeBuilder(themeName);
  }

  @override
  void didUpdateWidget(DynamicTheme oldWidget) {
    super.didUpdateWidget(oldWidget);
    theme = widget.themeBuilder(themeName);
  }

  @override
  Widget build(BuildContext context) {
    return widgetBuilder(context, theme);
  }

  void setTheme(String themeName) async {
    setState(() {
      this.theme = widget.themeBuilder(themeName);
      this.themeName = themeName;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(sharedPreferencesKey, themeName);
  }

  void setThemeData(ThemeData theme) {
    setState(() {
      this.theme = theme;
    });
  }

  Future<String> loadThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getString(sharedPreferencesKey));
  }
}
