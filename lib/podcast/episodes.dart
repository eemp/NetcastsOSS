import 'dart:math';
import 'package:flutter/material.dart';

import 'package:hear2learn/common/episode_tile.dart';
import 'package:hear2learn/episode/index.dart';
import 'package:hear2learn/models/episode.dart';

class PodcastEpisodesList extends StatelessWidget {
  Function onEpisodeDownload;
  List<Episode> episodes;

  PodcastEpisodesList({
    Key key,
    this.onEpisodeDownload,
    this.episodes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        itemCount: episodes.length,
        itemBuilder: (BuildContext context, int idx) {
          Episode episode = episodes[idx];
          String title = episode.title;

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EpisodePage(episode: episode)),
              );
            },
            child: EpisodeTile(
              subtitle: episode.getMetaLine(),
              title: title,
              options: IconButton(
                icon: Icon(Icons.get_app),
                onPressed: () async {
                  await onEpisodeDownload(episode.url, episode.toJson());
                }
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(),
        shrinkWrap: true,
      ),
    );
  }
}
