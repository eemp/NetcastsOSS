import 'package:flutter/material.dart';

import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:hear2learn/app.dart';
import 'package:hear2learn/widgets/common/bottom_app_bar_player.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  @override
  SettingsState createState() => new SettingsState();
}

class SettingsState extends State<Settings> {
  static final THEME_PREF = 'theme';
  final App app = App();
  final formKey = new GlobalKey<FormState>();
  final globalKey = new GlobalKey<ScaffoldState>();

  List<String> themes = [ 'Dark', 'Light' ];
  String theme;

  @override
  void initState() {
    super.initState();
    theme = app.prefs.getString(THEME_PREF);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            InputDecorator(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isDense: true,
                  items: themes.map((String theme) => DropdownMenuItem<String>(
                    child: Text(theme),
                    value: theme,
                  )).toList(),
                  onChanged: (String newTheme) {
                    Brightness brightness = newTheme == 'Dark'
                      ? Brightness.dark
                      : Brightness.light;

                    DynamicTheme.of(context).setBrightness(brightness);
                    setState(() {
                      theme = newTheme;
                    });

                    app.prefs.setString(THEME_PREF, newTheme);
                  },
                  value: theme,
                ),
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(Icons.color_lens),
                labelText: 'Theme',
              ),
            ),
          ],
          padding: EdgeInsets.all(16.0),
        ),
      ),
      bottomNavigationBar: BottomAppBarPlayer(),
    );
  }
}
