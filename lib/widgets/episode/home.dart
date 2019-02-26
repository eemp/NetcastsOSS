import 'package:flutter/material.dart';
import 'package:hear2learn/widgets/common/episode_tile.dart';
import 'package:hear2learn/widgets/episode/options.dart';
import 'package:hear2learn/widgets/episode/player.dart';
import 'package:hear2learn/models/episode.dart';

class EpisodeHome extends StatelessWidget {
  final Episode episode;
  final Function onDelete;
  final Function onDownload;
  final Function onFavorite;
  final Function onFinish;
  final Function onPause;
  final Function onPlay;
  final Function onShare;
  final Function onUnfavorite;
  final Function onUnfinish;

  const EpisodeHome({
    Key key,
    this.episode,
    this.onDelete,
    this.onDownload,
    this.onFavorite,
    this.onFinish,
    this.onPause,
    this.onPlay,
    this.onShare,
    this.onUnfavorite,
    this.onUnfinish,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text(episode.podcastTitle, style: Theme.of(context).textTheme.title, textAlign: TextAlign.left),
                ),
              ),
              margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            ),
            EpisodeTile(
              subtitle: episode.getMetaLine(),
              title: episode.title,
            ),
            EpisodeOptions(
              episode: episode,
              onDelete: onDelete,
              onDownload: onDownload,
              onFavorite: onFavorite,
              onFinish: onFinish,
              onShare: onShare,
              onUnfavorite: onUnfavorite,
              onUnfinish: onUnfinish,
            ),
          ],
        ),
        Container(
          child: Divider(
            color: Theme.of(context).dividerColor,
            height: 8.0,
          ),
          padding: const EdgeInsets.all(16.0),
        ),
        Container(
          child: EpisodePlayer(
            episode: episode,
            onPause: onPause,
            onPlay: onPlay,
          ),
          padding: const EdgeInsets.only(bottom: 16.0),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}
