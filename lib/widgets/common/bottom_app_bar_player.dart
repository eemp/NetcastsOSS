import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:hear2learn/widgets/episode/index.dart';
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/models/queued_episode.dart';
import 'package:hear2learn/redux/selectors.dart';
import 'package:hear2learn/redux/state.dart';

class BottomAppBarPlayer extends StatelessWidget {
  final Episode episode;
  final String mode;

  const BottomAppBarPlayer({
    Key key,
    this.episode,
    this.mode = 'default',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, QueuedEpisode>(
      converter: queuedEpisodeSelector,
      builder: (BuildContext context, QueuedEpisode queuedEpisode) {
        return queuedEpisode.episode != null
          ? BottomAppBar(
            child: ListTile(
              leading: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: CircularProgressIndicator(
                      strokeWidth: 3.0,
                      value: (queuedEpisode.position?.inSeconds?.toDouble() ?? 0)
                        / (queuedEpisode.duration?.inSeconds?.toDouble() ?? 1),
                    ),
                  ),
                  IconButton(
                    highlightColor: Colors.transparent,
                    icon: queuedEpisode.isPlaying
                      ? const Icon(Icons.pause)
                      : const Icon(Icons.play_arrow),
                    onPressed: () {
                      if(queuedEpisode.isPlaying) {
                        queuedEpisode.onPause();
                      }
                      else {
                        queuedEpisode.onPlay(queuedEpisode.episode);
                      }
                    },
                    splashColor: Colors.transparent,
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(builder: (BuildContext context) => EpisodePage(episode: queuedEpisode.episode)),
                );
              },
              subtitle: Text(queuedEpisode.episode.podcastTitle),
              title: Text(queuedEpisode.episode.title, overflow: TextOverflow.ellipsis),
            ),
          )
        : Container(height: 0.0, width: 0.0)
        ;
      },
    );
  }
}
