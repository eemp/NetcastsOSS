import 'package:flutter/material.dart';
import 'package:hear2learn/common/episode_tile.dart';
import 'package:hear2learn/episode/options.dart';
import 'package:hear2learn/episode/player.dart';
import 'package:hear2learn/models/episode.dart';

class EpisodeHome extends StatelessWidget {
  Episode episode;

  EpisodeHome({
    Key key,
    this.episode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(episode.podcastTitle, style: Theme.of(context).textTheme.title, textAlign: TextAlign.left),
              ),
            ),
            EpisodeTile(
              subtitle: episode.getMetaLine(),
              title: episode.title,
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
          child: EpisodePlayer(
            episode: episode,
          ),
          padding: EdgeInsets.only(bottom: 16.0),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}
