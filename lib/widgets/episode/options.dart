import 'package:flutter/material.dart';

import 'package:hear2learn/widgets/common/toggling_widget_pair.dart';
import 'package:hear2learn/models/episode.dart';

class EpisodeOptions extends StatelessWidget {
  Episode episode;
  Function onEpisodeDelete;
  Function onEpisodeDownload;
  TogglingWidgetPairController togglingWidgetPairController;

  EpisodeOptions({
    Key key,
    this.episode,
    this.onEpisodeDelete,
    this.onEpisodeDownload,
  }) : super(key: key) {
    togglingWidgetPairController = TogglingWidgetPairController(
      value: episode.download != null ? TogglingWidgetPairValue.active : TogglingWidgetPairValue.initial,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: TogglingWidgetPair(
            //debug: true,
            controller: togglingWidgetPairController.setValue(
              episode.download != null
                ? TogglingWidgetPairValue.active
                : TogglingWidgetPairValue.initial,
            ),
            activeWidget: RaisedButton(
              child: Row(
                children: [
                  Icon(Icons.delete),
                  Text('Delete'),
                ],
              ),
              onPressed: () async {
                togglingWidgetPairController.setLoadingValue();
                await onEpisodeDelete(episode);
                togglingWidgetPairController.setInitialValue();
              },
            ),
            initialWidget: RaisedButton(
              child: Row(
                children: [
                  Icon(Icons.get_app),
                  Text('Download'),
                ],
              ),
              onPressed: () async {
                togglingWidgetPairController.setLoadingValue();
                await onEpisodeDownload(episode);
                togglingWidgetPairController.setActiveValue();
              },
            ),
            loadingWidget: RaisedButton(
              child: Row(
                children: [
                  Icon(Icons.more_horiz),
                  Text('Downloading'),
                ],
              ),
            ),
          ),
        ),
        //Container(
          //child: IconButton(
            //icon: Icon(Icons.playlist_add),
            //iconSize: 24.0,
          //),
        //),
        //Container(
          //child: IconButton(
            //icon: Icon(Icons.favorite_border),
            //iconSize: 24.0,
          //),
        //),
        //Container(
          //child: IconButton(
            //icon: Icon(Icons.share),
            //iconSize: 24.0,
          //),
        //),
      ],
      //mainAxisAlignment: MainAxisAlignment.spaceAround,
    );
  }
}
