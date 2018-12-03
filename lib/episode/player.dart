import 'package:flutter/material.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:hear2learn/models/episode.dart';

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
  AudioPlayer player;
  bool isPlaying = false;
  double value;
  Duration duration, position;

  @override
  void initState() {
    super.initState();
    player = new AudioPlayer();
    player.durationHandler = (Duration duration) {
      setState(() {
        this.duration = duration;

        if (position != null) {
          this.value = (position.inSeconds / duration.inSeconds);
        }
      });
    };
    player.positionHandler = (Duration position) {
      setState(() {
        this.position = position;

        if (duration != null) {
          this.value = (position.inSeconds / duration.inSeconds);
        }
      });
    };
  }

  @override
  deactivate() {
    player.stop();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: RichText(
            text: TextSpan(
              text: this.widget.episode.title,
              style: Theme.of(context).textTheme.subhead
            ),
            textAlign: TextAlign.center,
          ),
          margin: EdgeInsets.only(bottom: 32.0),
        ),
        Container(
          child: duration != null
            ? Row(
              children: [
                Container(
                  child: Text(position.toString().substring(0, position.toString().indexOf('.'))),
                ),
                Expanded(
                  child: Slider(
                    activeColor: Theme.of(context).primaryColor,
                    //min: 0.0,
                    //max: duration != null ? duration.inSeconds.toDouble() : 0.0,
                    onChanged: (value) {
                      if (duration != null) {
                        var seconds = (duration.inSeconds * value).toInt();
                        player.seek(new Duration(seconds: seconds));
                      }
                    },
                    value: value ?? 0.0,
                  ),
                ),
                Container(
                  child: Text(duration.toString().substring(0, duration.toString().indexOf('.'))),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            )
          : null,
          margin: EdgeInsets.all(16.0),
        ),
        Container(
          child: Row(
            children: [
              //IconButton(
                //icon: Icon(Icons.skip_previous),
                //iconSize: 32.0,
              //),
              IconButton(
                icon: Icon(Icons.replay_10),
                iconSize: 40.0,
                onPressed: () {
                  player.seek(new Duration(seconds: position.inSeconds - 10));
                },
              ),
              RawMaterialButton(
                shape: new CircleBorder(),
                fillColor: Theme.of(context).primaryColor,
                splashColor: Theme.of(context).splashColor,
                highlightColor: Theme.of(context).accentColor.withOpacity(0.5),
                elevation: 10.0,
                highlightElevation: 5.0,
                onPressed: () {
                  if(isPlaying) {
                    player.pause();
                  }
                  else {
                    player.play(
                      this.widget.episode.url,
                    );
                  }

                  setState(() => isPlaying = !isPlaying);
                },
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
                onPressed: () {
                  player.seek(new Duration(seconds: position.inSeconds + 30));
                },
              ),
              //IconButton(
                //icon: Icon(Icons.skip_next),
                //iconSize: 32.0,
              //),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          margin: EdgeInsets.only(bottom: 8.0),
        ),
      ],
    );
  }
}

