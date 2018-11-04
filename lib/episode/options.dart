import 'package:flutter/material.dart';

class EpisodeOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: Icon(Icons.get_app),
          padding: EdgeInsets.only(right: 8.0),
        ),
        Container(
          child: Icon(Icons.playlist_add),
          padding: EdgeInsets.only(right: 8.0),
        ),
        Container(
          child: Icon(Icons.favorite_border),
          padding: EdgeInsets.only(right: 8.0),
        ),
        Container(
          child: Icon(Icons.share),
          padding: EdgeInsets.only(right: 8.0),
        ),
      ],
    );
  }
}

