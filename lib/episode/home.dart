import 'package:flutter/material.dart';
import 'package:hear2learn/common/episode_tile.dart';
import 'package:hear2learn/episode/options.dart';
import 'package:hear2learn/episode/player.dart';

class EpisodeHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text('Star Talk', style: Theme.of(context).textTheme.title, textAlign: TextAlign.left),
              ),
            ),
            EpisodeTile(
              image: Image.network('https://gpodder.net/logo/64/100/100a94c3c3f947d58ebee76ec98b757e44a95e21'),
              subtitle: 'Added: 2d ago. Duration: 50m.',
              title: 'Technosignatures: Detecting Alien Civilizations, with David Grinspoon',
            ),
            EpisodeOptions(),
          ],
        ),
        Container(
          child: Divider(
            color: Theme.of(context).dividerColor,
            height: 8.0,
          ),
          padding: EdgeInsets.all(16.0),
        ),
        Container(
          child: EpisodePlayer(),
          padding: EdgeInsets.only(bottom: 16.0),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}
