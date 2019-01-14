import 'package:flutter/material.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hear2learn/app.dart';
import 'package:hear2learn/episode/index.dart';
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/models/queued_episode.dart';
import 'package:hear2learn/redux/actions.dart';
import 'package:hear2learn/redux/selectors.dart';
import 'package:hear2learn/redux/state.dart';
import 'package:redux/redux.dart';

class BottomAppBarPlayer extends StatelessWidget {
  App app = App();
  Duration duration, position;
  Episode episode;
  bool isPlaying = false;
  String mode = 'default';
  double value;

  BottomAppBarPlayer({
    Key key,
    this.episode,
    this.mode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, QueuedEpisode>(
      converter: queuedEpisodeSelector,
      builder: (context, queuedEpisode) {
        return queuedEpisode.episode != null
          ? BottomAppBar(
            child: ListTile(
              leading: Stack(
                children: [
                  Positioned.fill(
                    child: CircularProgressIndicator(
                      strokeWidth: 3.0,
                      value: queuedEpisode.position.inSeconds.toDouble() / queuedEpisode.duration.inSeconds.toDouble(),
                    ),
                  ),
                  IconButton(
                    highlightColor: Colors.transparent,
                    icon: queuedEpisode.isPlaying
                      ? Icon(Icons.pause)
                      : Icon(Icons.play_arrow),
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
                  MaterialPageRoute(builder: (context) => EpisodePage(episode: queuedEpisode.episode)),
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
