import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:hear2learn/helpers/dash.dart' as dash;
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/redux/actions.dart';
import 'package:hear2learn/redux/selectors.dart';
import 'package:hear2learn/redux/state.dart';

class EpisodePlayer extends StatelessWidget {
  final Episode episode;
  final Function onPause;
  final Function onPlay;
  final Function onResume;

  const EpisodePlayer({
    Key key,
    this.episode,
    this.onPause,
    this.onPlay,
    this.onResume,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Episode>(
      converter: getEpisodeSelector(episode),
      builder: (BuildContext context, Episode episode) {
        final bool canPlay = dash.isNotEmpty(episode.downloadPath);
        final bool isActiveEpisode = isActive(episode);
        final bool isPlaying = episode?.isPlaying() ?? false;
        final bool isQueued = episode.url == episode?.url;
        final Duration duration = canPlay ? episode?.length : null;
        final Duration position = canPlay ? episode?.position : null;

        final double durationInSeconds = duration?.inSeconds?.toDouble() ?? 0.0;
        final double positionInSeconds = position?.inSeconds?.toDouble() ?? 0.0;

        return Container(
          child: Column(
            children: <Widget>[
              Container(
                child: RichText(
                  text: TextSpan(
                    text: episode.title,
                    style: Theme.of(context).textTheme.subhead
                  ),
                  textAlign: TextAlign.center,
                ),
                margin: const EdgeInsets.only(bottom: 32.0),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        position.toString().contains('.')
                          ? position.toString().substring(0, position.toString().indexOf('.'))
                          : '0:00:00'
                      ),
                    ),
                    Expanded(
                      child: Slider(
                        activeColor: Theme.of(context).accentColor,
                        min: 0.0,
                        max: durationInSeconds,
                        onChanged: isQueued ? (double value) {
                          seekInEpisode(Duration(seconds: value.toInt()));
                        } : null,
                        value: dash.clamp(0.0, positionInSeconds ?? 0.0, durationInSeconds),
                      ),
                    ),
                    Container(
                      child: ( duration?.toString()?.indexOf('.') ?? -1 ) >= 0
                        ? Text(duration.toString().substring(0, duration.toString().indexOf('.')))
                        : const Text('0:00:00'),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ),
                margin: const EdgeInsets.all(16.0),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.replay_10),
                      iconSize: 40.0,
                      onPressed: canPlay ? () {
                        seekInEpisode(Duration(seconds: position.inSeconds - 10));
                      } : null,
                    ),
                    RawMaterialButton(
                      shape: const CircleBorder(),
                      fillColor: canPlay ? Theme.of(context).accentColor : Colors.grey,
                      splashColor: Theme.of(context).splashColor,
                      highlightColor: Theme.of(context).accentColor.withOpacity(0.5),
                      elevation: 10.0,
                      highlightElevation: 5.0,
                      onPressed: canPlay ? () {
                        if(isPlaying) {
                          onPause();
                        }
                        else {
                          if(episode.status == EpisodeStatus.PAUSED && isActiveEpisode) {
                            onResume();
                          }
                          else {
                            onPlay();
                          }
                        }
                      } : null,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                          size: 35.0,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.forward_30),
                      iconSize: 40.0,
                      onPressed: canPlay ? () {
                        seekInEpisode(Duration(seconds: position.inSeconds + 30));
                      } : null,
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ),
                margin: const EdgeInsets.only(bottom: 8.0),
              ),
            ],
          ),
          margin: const EdgeInsets.all(16.0),
        );
      },
    );
  }
}
