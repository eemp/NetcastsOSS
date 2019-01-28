import 'package:flutter/material.dart';

import 'package:hear2learn/widgets/common/episode_tile.dart';
import 'package:hear2learn/widgets/common/toggling_widget_pair.dart';
import 'package:hear2learn/widgets/episode/index.dart';
import 'package:hear2learn/models/episode.dart';

class PodcastEpisodesList extends StatelessWidget {
  final Function onEpisodeDelete;
  final Function onEpisodeDownload;
  final List<Episode> episodes;

  const PodcastEpisodesList({
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
          final Episode episode = episodes[idx];
          final String title = episode.title;

          final TogglingWidgetPairController togglingWidgetPairController = TogglingWidgetPairController(
            value: episode.download != null ? TogglingWidgetPairValue.active : TogglingWidgetPairValue.initial,
          );

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(builder: (BuildContext context) => EpisodePage(episode: episode)),
              );
            },
            child: EpisodeTile(
              subtitle: episode.getMetaLine(),
              title: title,
              options: TogglingWidgetPair(
                controller: togglingWidgetPairController,
                activeWidget: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    //togglingWidgetPairController.setLoadingValue();
                    await onEpisodeDelete(episode);
                    togglingWidgetPairController.setInitialValue();
                  },
                ),
                initialWidget: IconButton(
                  icon: const Icon(Icons.get_app),
                  onPressed: () async {
                    togglingWidgetPairController.setLoadingValue();
                    await onEpisodeDownload(episode, onProgress: (int received, int total) {
                      togglingWidgetPairController.setProgressValue(received/total);
                    });
                    togglingWidgetPairController.setActiveValue();
                  },
                ),
                loadingWidget: ({ double progressValue }) => IconButton(
                  icon: CircularProgressIndicator(value: progressValue),
                  onPressed: null,
                ),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => Divider(),
        shrinkWrap: true,
      ),
    );
  }
}
