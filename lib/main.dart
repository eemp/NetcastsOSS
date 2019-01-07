import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:hear2learn/app.dart';
import 'package:hear2learn/home.dart';

void main() async {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  App app = new App();
  await app.init();

  runApp(AppWidget());
}

class AppWidget extends StatelessWidget {
  final appTitle = 'App';

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => ThemeData(
        accentColor: Colors.pink[900],
        brightness: brightness,
        fontFamily: 'OpenSans',
        primaryColor: Colors.blueGrey[500],
        primaryTextTheme: Typography(platform: TargetPlatform.android).white,
      ),
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          title: appTitle,
          home: Home(),
          theme: theme,
        );
      },
    );
  }
}
