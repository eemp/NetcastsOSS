import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:hear2learn/home.dart';

void main() async {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(App());
}

class App extends StatelessWidget {
  final appTitle = 'App';

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => ThemeData(
        accentColor: Colors.blue,
        brightness: brightness,
        fontFamily: 'OpenSans',
        primaryColor: Colors.pink[900],
        primaryTextTheme: Typography(platform: TargetPlatform.android).white,
      ),
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          title: appTitle,
          home: Homepage(title: appTitle),
          theme: theme,
        );
      },
    );
  }
}

class Homepage extends StatelessWidget {
  final String title;

  Homepage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Home();
  }
}

