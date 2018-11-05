import 'package:flutter/material.dart';
import 'package:hear2learn/common/episode_tile.dart';
import 'package:hear2learn/episode/options.dart';
import 'package:hear2learn/episode/player.dart';

class EpisodeHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          child: EpisodeTile(
            image: Image.network('https://content.production.cdn.art19.com/images/ea/bf/ce/0f/eabfce0f-4d38-4600-b5b9-3e0043b94987/e76f68f407f76ddc2b497f144e037abfe10216f49cae2716c5e174f705b1c05d83f0ff7082da9d6180d42d5a999d7979a140becf59cdc0b91aeaa0e0906793e5.jpeg'),
            subtitle: 'Added: 2d ago. Duration: 50m.',
            title: 'Technosignatures: Detecting Alien Civilizations, with David Grinspoon',
          ),
          padding: EdgeInsets.only(bottom: 16.0),
        ),
        Container(
          child: EpisodeOptions(),
          padding: EdgeInsets.only(bottom: 16.0),
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
    );
  }
}
