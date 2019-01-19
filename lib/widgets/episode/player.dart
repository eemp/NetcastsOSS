import 'package:flutter/material.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hear2learn/app.dart';
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/models/queued_episode.dart';
import 'package:hear2learn/redux/actions.dart';
import 'package:hear2learn/redux/selectors.dart';
import 'package:hear2learn/redux/state.dart';
import 'package:redux/redux.dart';

class EpisodePlayer extends StatefulWidget {
  Episode episode;

  EpisodePlayer({
    Key key,
    this.episode,
  }) : super(key: key);

  @override
  EpisodePlayerState createState() => new EpisodePlayerState();
}

class EpisodePlayerState extends State<EpisodePlayer> {
  final App app = App();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, QueuedEpisode>(
      converter: queuedEpisodeSelector,
      builder: (context, queuedEpisode) {
        Duration duration = queuedEpisode.duration;
        Episode episode = queuedEpisode.episode ?? widget.episode;
        bool isPlaying = queuedEpisode.isPlaying;
        Function onPause = queuedEpisode.onPause;
        Function onPlay = queuedEpisode.onPlay;
        Duration position = queuedEpisode.position;

        return Column(
          children: [
            Container(
              child: RichText(
                text: TextSpan(
                  text: episode.title,
                  style: Theme.of(context).textTheme.subhead
                ),
                textAlign: TextAlign.center,
              ),
              margin: EdgeInsets.only(bottom: 32.0),
            ),
            Container(
              child: Row(
                children: [
                  Container(
                    child: Text(
                      position.toString().indexOf('.') >= 0
                        ? position.toString().substring(0, position.toString().indexOf('.'))
                        : '0:00:00'
                    ),
                  ),
                  Expanded(
                    child: Slider(
                      activeColor: Theme.of(context).accentColor,
                      min: 0.0,
                      max: duration?.inSeconds?.toDouble() ?? 0.0,
                      onChanged: episode.download != null ? (value) {
                        seekInEpisode(Duration(seconds: value.toInt()));
                      } : null,
                      value: position?.inSeconds?.toDouble() ?? 0.0,
                    ),
                  ),
                  Container(
                    child: ( duration?.toString()?.indexOf('.') ?? -1 ) >= 0
                      ? Text(duration.toString().substring(0, duration.toString().indexOf('.')))
                      : Text('0:00:00'),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
              margin: EdgeInsets.all(16.0),
            ),
            Container(
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.replay_10),
                    iconSize: 40.0,
                    onPressed: episode.download != null ? () {
                      seekInEpisode(Duration(seconds: position.inSeconds - 10));
                    } : null,
                  ),
                  RawMaterialButton(
                    shape: new CircleBorder(),
                    fillColor: episode.download != null ? Theme.of(context).accentColor : Colors.grey,
                    splashColor: Theme.of(context).splashColor,
                    highlightColor: Theme.of(context).accentColor.withOpacity(0.5),
                    elevation: 10.0,
                    highlightElevation: 5.0,
                    onPressed: episode.download != null ? () {
                      if(isPlaying) {
                        onPause();
                      }
                      else {
                        onPlay(widget.episode);
                      }
                    } : null,
                    child: new Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                        size: 35.0,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.forward_30),
                    iconSize: 40.0,
                    onPressed: episode.download != null ? () {
                      seekInEpisode(new Duration(seconds: position.inSeconds + 30));
                    } : null,
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
              margin: EdgeInsets.only(bottom: 8.0),
            ),
          ],
        );
      },
    );
  }
}
