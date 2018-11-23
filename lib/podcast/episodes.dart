import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hear2learn/common/episode_tile.dart';
import 'package:hear2learn/models/episode.dart';
//import 'package:kilobyte';

Widget mockEpisodeImage = Image.asset("images/fff.png");

class PodcastEpisodesList extends StatelessWidget {
  List<Episode> episodes;

  PodcastEpisodesList({
    Key key,
    this.episodes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: episodes.length,
        itemBuilder: (BuildContext context, int idx) {
          String title = episodes[idx].title;
          num size = episodes[idx].size;
          num sizeInMegabytes = size / 10e6;

          return EpisodeTile(
            //image: mockEpisodeImage,
            subtitle: 'Added: 2d ago. Duration: 50m.',
            title: title,
            options: Column(
              children: [
                IconButton(icon: Icon(Icons.get_app)),
                //Text(Size(bytes: size) + ' MB'),
                Text(sizeInMegabytes.toStringAsFixed(2) + ' MB'),
              ],
            ),
          );
        },
        shrinkWrap: true,
      ),
    );
  }
}
