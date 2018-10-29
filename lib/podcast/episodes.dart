import 'package:flutter/material.dart';

class PodcastEpisodesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Container(
            child: ListTile(
              title: Text('The Enchanted Nightingale'),
              subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
              isThreeLine: true,
              leading: new Container(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    new Image.asset("images/fff.png")
                  ]
                ),
                constraints: new BoxConstraints(maxWidth: 64.0, minWidth: 64.0),
              ),
              trailing: IconButton(icon: Icon(Icons.get_app)),
            ),
            margin: const EdgeInsets.only(bottom: 8.0),
          ),
          Container(
            child: ListTile(
              title: Text('The Enchanted Nightingale'),
              subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
              isThreeLine: true,
              leading: new Container(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    new Image.asset("images/fff.png")
                  ]
                ),
                constraints: new BoxConstraints(maxWidth: 64.0, minWidth: 64.0),
              ),
              trailing: IconButton(icon: Icon(Icons.get_app)),
            ),
            margin: const EdgeInsets.only(bottom: 8.0),
          ),
        ],
        padding: const EdgeInsets.all(16.0),
      ),
    );
  }
}
