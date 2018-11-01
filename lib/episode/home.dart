import 'package:flutter/material.dart';
import 'package:hear2learn/common/circle_button.dart';

class EpisodeHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          child: Stack(
            alignment: const Alignment(0.0, 0.0),
            children: [
              Image.asset(
                'images/sample-podcast-main.jpg',
                fit: BoxFit.cover,
                //height: 240.0,
              ),
              Row(
                children: [
                  FloatingActionButton(
                    backgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
                    child: Icon(Icons.replay_10),
                    tooltip: 'Play',
                  ),
                  CircleButton(
                    icon: Icon(Icons.play_arrow),
                  ),
                  FloatingActionButton(
                    backgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
                    child: Icon(Icons.forward_30),
                    tooltip: 'Play',
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
            ],
          ),
          padding: const EdgeInsets.only(bottom: 16.0),
        ),
        Container(
          child: Text(
            'A new family history podcast hosted by A.J. Jacobs.  They say we\'re one big family: this is the show that proves it.  You will be filled with delight... or abject horror.  You never know.  It\'s family.',
            softWrap: true,
            style: Theme.of(context).textTheme.body1,
          ),
          padding: const EdgeInsets.only(bottom: 16.0),
        ),
      ],
    );
  }
}
