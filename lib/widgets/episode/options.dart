import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:hear2learn/helpers/dash.dart' as dash;
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/redux/selectors.dart';
import 'package:hear2learn/redux/state.dart';
import 'package:hear2learn/widgets/common/outline_icon_button.dart';

class EpisodeOptions extends StatelessWidget {
  final Episode episode;
  final Function onDelete;
  final Function onDownload;
  final Function onFavorite;
  final Function onFinish;
  final Function onShare;
  final Function onUnfavorite;
  final Function onUnfinish;

  const EpisodeOptions({
    Key key,
    this.episode,
    this.onDelete,
    this.onDownload,
    this.onFavorite,
    this.onFinish,
    this.onShare,
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
    return RaisedButton.icon(
      icon: const Icon(Icons.delete),
      label: const Text('Delete'),
      onPressed: onDelete,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
    );
  }

  Widget buildDownloadOption(Episode episode) {
    return OutlineButton.icon(
      icon: const Icon(Icons.get_app),
      label: const Text('Download'),
      onPressed: onDownload,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
    );
  }

  Widget buildDownloadProgress(Episode episode) {
    return OutlineButton.icon(
      icon: const Icon(Icons.more_horiz),
      label: Text('Downloaded ${(episode.progress * 100).truncateToDouble().toString()}%'),
      onPressed: null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
    );
  }

  Widget buildFavoritesOptions(Episode episode) {
    return episode.isFavorited == true
      ? OutlineIconButton(
        icon: Icons.favorite,
        onPressed: onUnfavorite,
      )
      : OutlineIconButton(
        icon: Icons.favorite_border,
        onPressed: onFavorite,
      );
  }

  Widget buildFinishOptions(Episode episode) {
    return episode.isFinished == true
      ? OutlineIconButton(
        icon: Icons.done,
        onPressed: onUnfinish,
      )
      : OutlineIconButton(
        icon: Icons.done_outline,
        onPressed: onFinish,
      );
  }

  Widget buildShareOptions(Episode episode) {
    return OutlineIconButton(
      icon: Icons.share,
      onPressed: onShare,
    );
  }
}
