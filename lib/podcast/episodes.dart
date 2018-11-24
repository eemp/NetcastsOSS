import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import 'package:kilobyte';
import 'package:timeago/timeago.dart' as timeago;

import 'package:hear2learn/common/episode_tile.dart';
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

          return EpisodeTile(
            subtitle: 'Size: ' + sizeInMegabytes.toStringAsFixed(2) + ' MB.  Added: ' + friendlyDate(episode.pubDate) + '.',
            title: title,
            options: IconButton(icon: Icon(Icons.get_app)),
          );
        },
        separatorBuilder: (context, index) => Divider(),
        shrinkWrap: true,
      ),
    );
  }

  String friendlyDate(dateStr) {
    String shortFormat = 'EEE, dd MMM yyyy';
    DateFormat podcastDateFormat = DateFormat(shortFormat);
    return timeago.format(podcastDateFormat.parseLoose(dateStr.substring(0, shortFormat.length)));
  }
}
