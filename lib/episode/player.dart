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
  Episode get episode => widget.episode;
  AudioPlayer player;
  bool isPlaying = false;
  double value;
  Duration duration, position;

  @override
  void initState() {
    super.initState();
    duration = new Duration(seconds: 0);
    player = new AudioPlayer();
    player.completionHandler = () {
      setState(() {
        isPlaying = false;
        position = new Duration(seconds: 0);
        value = 0.0;
      });
    };
    player.durationHandler = (Duration duration) {
      setState(() {
        this.duration = duration;
        if (position != null) {
          value = position.inSeconds.toDouble();
        }
      });
    };
    player.positionHandler = (Duration position) {
      setState(() {
        this.position = position;
        value = position.inSeconds.toDouble();
      });
    };
    value = 0.0;
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
                  activeColor: Theme.of(context).primaryColor,
                  min: 0.0,
                  max: duration.inSeconds.toDouble(),
                  onChanged: widget.episode.download != null ? (value) {
                    player.seek(new Duration(seconds: value.toInt()));
                  } : null,
                  value: value > 0.0 ? value : 0.0,
                ),
              ),
              Container(
                child: Text(duration.toString().substring(0, duration.toString().indexOf('.'))),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
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
                onPressed: widget.episode.download != null ? () {
                  player.seek(new Duration(seconds: position.inSeconds - 10));
                } : null,
              ),
              RawMaterialButton(
                shape: new CircleBorder(),
                fillColor: widget.episode.download != null ? Theme.of(context).primaryColor : Colors.grey,
                splashColor: Theme.of(context).splashColor,
                highlightColor: Theme.of(context).accentColor.withOpacity(0.5),
                elevation: 10.0,
                highlightElevation: 5.0,
                onPressed: widget.episode.download != null ? () {
                  if(isPlaying) {
                    player.pause();
                  }
                  else {
                    player.play(
                      this.widget.episode.download.downloadPath,
                      isLocal: true,
                    );
                  }

                  setState(() => isPlaying = !isPlaying);
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
                onPressed: widget.episode.download != null ? () {
                  player.seek(new Duration(seconds: position.inSeconds + 30));
                } : null,
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

