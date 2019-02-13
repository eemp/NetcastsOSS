import 'package:flutter/material.dart';

import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/widgets/common/episode_tile_connector.dart';

class PodcastEpisodesList extends StatelessWidget {
  final List<Episode> episodes;

  const PodcastEpisodesList({
    Key key,
    this.episodes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        itemCount: episodes.length,
        itemBuilder: (BuildContext context, int idx) {
          final Episode episode = episodes[idx];
          return EpisodeTileConnector(
            episode: episode,
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        shrinkWrap: true,
      ),
    );
  }
}
