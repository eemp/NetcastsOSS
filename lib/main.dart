import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hear2learn/home.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(App());
}

class App extends StatelessWidget {
  final appTitle = 'App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: Homepage(title: appTitle),
      theme: ThemeData(
        accentColor: Colors.blue,
        brightness: Brightness.dark,
        fontFamily: 'OpenSans',
        primaryColor: Colors.pink[900],
        primaryTextTheme: Typography(platform: TargetPlatform.android).white,
      ),
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

