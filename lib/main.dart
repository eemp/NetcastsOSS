import 'package:flutter/material.dart';

import 'home.dart';
import 'podcast/index.dart';
import 'podcast/episode.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  final appTitle = 'App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: Homepage(title: appTitle),
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
                  color: Colors.blue,
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
              title: Text('Podcast Episode Page'),
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

