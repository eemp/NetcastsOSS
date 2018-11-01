import 'package:flutter/material.dart';

import 'package:hear2learn/home.dart';
import 'package:hear2learn/podcast/index.dart';
import 'package:hear2learn/episode/index.dart';

void main() => runApp(App());

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
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('Homepage!')),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the Drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              child: DrawerHeader(
                child: Text('Debug Menu'),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            ListTile(
              title: Text('Homepage'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
            ),
            ListTile(
              title: Text('Podcast Page'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Podcast()),
                );
              },
            ),
            ListTile(
              title: Text('Episode Page'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Episode()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

