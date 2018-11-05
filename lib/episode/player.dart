import 'package:flutter/material.dart';

class EpisodePlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Center(
            child: Text('Star Talk', style: Theme.of(context).textTheme.title),
          ),
          margin: EdgeInsets.only(top: 32.0, bottom: 8.0),
        ),
        Container(
          child: RichText(
            text: TextSpan(
              text: 'Technosignatures: Detecting Alien Civilizations with David Grinspoon',
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
                    //backgroundColor: Theme.of(context).accentColor,
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
              //IconButton(
                //icon: Icon(Icons.play_arrow),
                //iconSize: 64.0,
              //),
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

