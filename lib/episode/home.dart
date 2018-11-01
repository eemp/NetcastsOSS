import 'package:flutter/material.dart';

class EpisodeHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          child: Image.asset(
            'images/sample-podcast-main.jpg',
            fit: BoxFit.cover,
            //height: 240.0,
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
