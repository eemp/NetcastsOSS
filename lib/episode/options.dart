import 'package:flutter/material.dart';

class EpisodeOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: IconButton(
            icon: Icon(Icons.get_app),
            iconSize: 32.0,
          ),
        ),
        Container(
          child: IconButton(
            icon: Icon(Icons.playlist_add),
            iconSize: 32.0,
          ),
        ),
        Container(
          child: IconButton(
            icon: Icon(Icons.favorite_border),
            iconSize: 32.0,
          ),
        ),
        Container(
          child: IconButton(
            icon: Icon(Icons.share),
            iconSize: 32.0,
          ),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceAround,
    );
  }
}

