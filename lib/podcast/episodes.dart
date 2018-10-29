import 'package:flutter/material.dart';

class PodcastEpisodesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Container(
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.album),
                    title: Text('The Enchanted Nightingale'),
                    subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                  ),
                ],
              ),
              elevation: 8.0,
            ),
            margin: const EdgeInsets.only(bottom: 8.0),
          ),
          Container(
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.album),
                    title: Text('The Enchanted Nightingale'),
                    subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                  ),
                ],
              ),
              elevation: 8.0,
            ),
            margin: const EdgeInsets.only(bottom: 8.0),
          ),
          Container(
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.album),
                    title: Text('The Enchanted Nightingale'),
                    subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                  ),
                ],
              ),
            ),
            margin: const EdgeInsets.only(bottom: 8.0),
          ),
          Container(
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.album),
                    title: Text('The Enchanted Nightingale'),
                    subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                  ),
                ],
              ),
            ),
            margin: const EdgeInsets.only(bottom: 8.0),
          ),
          Container(
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.album),
                    title: Text('The Enchanted Nightingale'),
                    subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                  ),
                ],
              ),
            ),
            margin: const EdgeInsets.only(bottom: 8.0),
          ),
          Container(
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.album),
                    title: Text('The Enchanted Nightingale'),
                    subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                  ),
                ],
              ),
            ),
            margin: const EdgeInsets.only(bottom: 8.0),
          ),
          Container(
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.album),
                    title: Text('The Enchanted Nightingale'),
                    subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                  ),
                ],
              ),
            ),
            margin: const EdgeInsets.only(bottom: 8.0),
          ),
        ],
        padding: const EdgeInsets.all(16.0),
      ),
    );
  }
}
