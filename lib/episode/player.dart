import 'package:flutter/material.dart';
import 'package:hear2learn/models/episode.dart';

class EpisodePlayer extends StatelessWidget {
  Episode episode;

  EpisodePlayer({
    Key key,
    this.episode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                child: Text('10:23'),
              ),
              Expanded(
                child: Container(
                  child: LinearProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                    value: 0.33,
                  ),
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                ),
              ),
              Container(
                child: Text('31:00'),
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
                icon: Icon(Icons.skip_previous),
                iconSize: 32.0,
              ),
              IconButton(
                icon: Icon(Icons.replay_10),
                iconSize: 40.0,
              ),
              RawMaterialButton(
                shape: new CircleBorder(),
                fillColor: Theme.of(context).primaryColor,
                splashColor: Theme.of(context).splashColor,
                highlightColor: Theme.of(context).accentColor.withOpacity(0.5),
                elevation: 10.0,
                highlightElevation: 5.0,
                //onPressed: onPressed,
                child: new Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 35.0,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.forward_30),
                iconSize: 40.0,
              ),
              IconButton(
                icon: Icon(Icons.skip_next),
                iconSize: 32.0,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          margin: EdgeInsets.only(bottom: 8.0),
        ),
      ],
    );
  }
}

