import 'package:flutter/material.dart';

import 'package:hear2learn/constants.dart';
import 'package:hear2learn/widgets/downloads/index.dart';
import 'package:hear2learn/widgets/favorites/index.dart';
import 'package:hear2learn/widgets/home/index.dart';
import 'package:hear2learn/widgets/queue/index.dart';
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
                image: const DecorationImage(
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
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => Home(),
                  settings: const RouteSettings(name: Home.routeName),
                ),
              );
            },
            title: const Text('Home'),
          ),
          ListTile(
            leading: const Icon(Icons.explore),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => PodcastSearch(),
                  settings: const RouteSettings(name: PodcastSearch.routeName),
                ),
              );
            },
            title: const Text('Explore'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.collections_bookmark),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => SubscriptionsPage(),
                  settings: const RouteSettings(name: SubscriptionsPage.routeName),
                ),
              );
            },
            title: const Text(LIBRARY_LABEL),
          ),
          ListTile(
            leading: const Icon(Icons.folder),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => DownloadPage(),
                  settings: const RouteSettings(name: DownloadPage.routeName),
                ),
              );
            },
            title: const Text('Downloads'),
          ),
          ListTile(
            leading: const Icon(Icons.folder),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => QueuedListPage(),
                  settings: const RouteSettings(name: QueuedListPage.routeName),
                ),
              );
            },
            title: const Text('Queue'),
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => FavoritePage(),
                  settings: const RouteSettings(name: FavoritePage.routeName),
                ),
              );
            },
            title: const Text('Favorites'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => Settings(),
                  settings: const RouteSettings(name: Settings.routeName),
                ),
              );
            },
            title: const Text('Settings'),
          ),
        ],
      ),
    );
  }
}
