import 'dart:math';
import 'package:flutter/material.dart';

import 'package:hear2learn/common/episode_tile.dart';
import 'package:hear2learn/episode/index.dart';
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/services/feeds/podcast.dart';

class PodcastEpisodesList extends StatelessWidget {
  String podcastUrl;

  PodcastEpisodesList({
    Key key,
    this.podcastUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<List<Episode>> episodesFuture = getPodcastEpisodes(podcastUrl);

    return FutureBuilder(
      future: episodesFuture,
      builder: (BuildContext context, AsyncSnapshot<List<Episode>> snapshot) {
        return snapshot.hasData
          ? buildEpisodesList(snapshot.data)
          : Padding(
            padding: EdgeInsets.all(32.0),
            child: Center(child: CircularProgressIndicator()),
          );
      },
    );
  }

  Widget buildEpisodesList(episodes) {
    return Container(
      child: ListView.separated(
        itemCount: episodes.length,
        itemBuilder: (BuildContext context, int idx) {
          Episode episode = episodes[idx];
          String title = episode.title;
          num size = episode.size;
          num sizeInMegabytes = size / 10e6;

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
              options: IconButton(icon: Icon(Icons.get_app)),
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(),
        shrinkWrap: true,
      ),
    );
  }
}
