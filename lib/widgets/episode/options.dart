import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/redux/selectors.dart';
import 'package:hear2learn/redux/state.dart';

class EpisodeOptions extends StatelessWidget {
  final Episode episode;
  final Function onEpisodeDelete;
  final Function onEpisodeDownload;

  const EpisodeOptions({
    Key key,
    this.episode,
    this.onEpisodeDelete,
    this.onEpisodeDownload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          child: StoreConnector<AppState, Episode>(
            converter: getEpisodeSelector(episode),
            builder: episodeOptionsBuilder,
          ),
        ),
      ],
      //mainAxisAlignment: MainAxisAlignment.spaceAround,
    );
  }

  Widget episodeOptionsBuilder(BuildContext context, Episode episode) {
    return episode.downloadPath != null
      ? buildDeleteOption(episode)
      : episode.progress != null
        ? buildDownloadProgress(episode)
        : buildDownloadOption(episode);
  }

  Widget buildDeleteOption(Episode episode) {
    return RaisedButton(
      child: Row(
        children: const <Widget>[
          Icon(Icons.delete),
          Text('Delete'),
        ],
      ),
      onPressed: () {
        onEpisodeDelete(episode);
      },
    );
  }

  Widget buildDownloadOption(Episode episode) {
    return RaisedButton(
      child: Row(
        children: const <Widget>[
          Icon(Icons.get_app),
          Text('Download'),
        ],
      ),
      onPressed: () {
        onEpisodeDownload(episode);
      },
    );
  }

  Widget buildDownloadProgress(Episode episode) {
    return RaisedButton(
      child: Row(
        children: <Widget>[
          const Icon(Icons.more_horiz),
          Text('Downloaded ${(episode.progress * 100).truncateToDouble().toString()}%'),
        ],
      ),
      onPressed: null,
    );
  }
}
