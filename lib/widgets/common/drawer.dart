import 'package:flutter/material.dart';

import 'package:hear2learn/widgets/downloads/index.dart';
import 'package:hear2learn/widgets/home/index.dart';
import 'package:hear2learn/widgets/search/index.dart';
import 'package:hear2learn/widgets/settings/index.dart';
import 'package:hear2learn/widgets/subscriptions/index.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the Drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: ExactAssetImage('images/drawer-header--balloons.jpg'),
                ),
              ),
              child: null,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(builder: (BuildContext context) => Home()),
              );
            },
            title: const Text('Home'),
          ),
          ListTile(
            leading: const Icon(Icons.explore),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(builder: (BuildContext context) => PodcastSearch()),
              );
            },
            title: const Text('Explore'),
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.subscriptions),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(builder: (BuildContext context) => SubscriptionsPage()),
              );
            },
            title: const Text('Your Podcasts'),
          ),
          ListTile(
            leading: const Icon(Icons.get_app),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(builder: (BuildContext context) => DownloadPage()),
              );
            },
            title: const Text('Downloads'),
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(builder: (BuildContext context) => Settings()),
              );
            },
            title: const Text('Settings'),
          ),
        ],
      ),
    );
  }
}
