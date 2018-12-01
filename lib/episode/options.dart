import 'package:flutter/material.dart';

class EpisodeOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: IconButton(
            icon: Icon(Icons.get_app),
            iconSize: 24.0,
          ),
        ),
        Container(
          child: IconButton(
            icon: Icon(Icons.playlist_add),
            iconSize: 24.0,
          ),
        ),
        Container(
          child: IconButton(
            icon: Icon(Icons.favorite_border),
            iconSize: 24.0,
          ),
        ),
        Container(
          child: IconButton(
            icon: Icon(Icons.share),
            iconSize: 24.0,
          ),
        ),
      ],
      //mainAxisAlignment: MainAxisAlignment.spaceAround,
    );
  }
}

