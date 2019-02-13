import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:hear2learn/helpers/dash.dart' as dash;
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/redux/selectors.dart';
import 'package:hear2learn/redux/state.dart';
import 'package:share/share.dart';

class EpisodeOptions extends StatelessWidget {
  final Episode episode;
  final Function onDelete;
  final Function onDownload;
  final Function onFavorite;
  final Function onFinish;
  final Function onUnfavorite;
  final Function onUnfinish;

  const EpisodeOptions({
    Key key,
    this.episode,
    this.onDelete,
    this.onDownload,
    this.onFavorite,
    this.onFinish,
    this.onUnfavorite,
    this.onUnfinish,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Episode>(
      converter: getEpisodeSelector(episode),
      builder: (BuildContext context, Episode episode) {
        return Row(
          children: <Widget>[
            buildDownloadDeleteOptions(episode),
            buildFavoritesOptions(episode),
            buildFinishOptions(episode),
            buildShareOptions(episode),
          ],
        );
      },
    );
  }

  Widget buildDownloadDeleteOptions(Episode episode) {
    return dash.isNotEmpty(episode.downloadPath)
      ? buildDeleteOption(episode)
      : episode.status == EpisodeStatus.DOWNLOADING
        ? buildDownloadProgress(episode)
        : buildDownloadOption(episode);
  }

  Widget buildDeleteOption(Episode episode) {
    return FlatButton.icon(
      icon: const Icon(Icons.delete),
      label: const Text('Delete'),
      onPressed: onDelete,
    );
  }

  Widget buildDownloadOption(Episode episode) {
    return FlatButton.icon(
      icon: const Icon(Icons.get_app),
      label: const Text('Download'),
      onPressed: onDownload,
    );
  }

  Widget buildDownloadProgress(Episode episode) {
    return FlatButton.icon(
      icon: const Icon(Icons.more_horiz),
      label: Text('Downloaded ${(episode.progress * 100).truncateToDouble().toString()}%'),
      onPressed: null,
    );
  }

  Widget buildFavoritesOptions(Episode episode) {
    return episode.isFavorited == true
      ? IconButton(
        icon: const Icon(Icons.favorite),
        onPressed: onUnfavorite,
        tooltip: 'Unfavorite',
      )
      : IconButton(
        icon: const Icon(Icons.favorite_border),
        onPressed: onFavorite,
        tooltip: 'Favorite',
      );
  }

  Widget buildFinishOptions(Episode episode) {
    return episode.isFinished == true
      ? IconButton(
        icon: const Icon(Icons.done),
        onPressed: onUnfinish,
        tooltip: 'Mark Not Played',
      )
      : IconButton(
        icon: const Icon(Icons.done_outline),
        onPressed: onFinish,
        tooltip: 'Mark Played',
      );
  }

  Widget buildShareOptions(Episode episode) {
    return IconButton(
      icon: const Icon(Icons.share),
      onPressed: () {
        Share.share('Check out ${episode.title}, an episode of the ${episode.podcastTitle} podcast');
      },
      tooltip: 'Share',
    );
  }
}
