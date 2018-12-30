import 'dart:math';
import 'package:flutter/material.dart';

import 'package:hear2learn/common/episode_tile.dart';
import 'package:hear2learn/common/toggling_widget_pair.dart';
import 'package:hear2learn/episode/index.dart';
import 'package:hear2learn/models/episode.dart';

class PodcastEpisodesList extends StatelessWidget {
  Function onEpisodeDelete;
  Function onEpisodeDownload;
  List<Episode> episodes;

  PodcastEpisodesList({
    Key key,
    this.onEpisodeDelete,
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

          TogglingWidgetPairController togglingWidgetPairController = TogglingWidgetPairController(
            value: episode.download != null ? TogglingWidgetPairValue.active : TogglingWidgetPairValue.initial,
          );

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
              options: TogglingWidgetPair(
                controller: togglingWidgetPairController.setValue(
                  episode.download != null
                    ? TogglingWidgetPairValue.active
                    : TogglingWidgetPairValue.initial,
                ),
                activeWidget: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    togglingWidgetPairController.setLoadingValue();
                    await onEpisodeDelete(episode);
                    togglingWidgetPairController.setInitialValue();
                  },
                ),
                initialWidget: IconButton(
                  icon: Icon(Icons.get_app),
                  onPressed: () async {
                    togglingWidgetPairController.setLoadingValue();
                    await onEpisodeDownload(episode);
                    togglingWidgetPairController.setActiveValue();
                  },
                ),
                loadingWidget: IconButton(
                  icon: CircularProgressIndicator(value: null),
                ),
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
