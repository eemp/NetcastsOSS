import 'package:flutter/material.dart';

import 'package:hear2learn/models/podcast.dart';

class Tags extends StatelessWidget {
  final List<Genre> genres;

  const Tags({
    Key key,
    this.genres,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(genres == null || genres.isEmpty) {
      return Container(height: 0.0, width: 0.0);
    }

    genres.sort((Genre a, Genre b) => a.name.length.compareTo(b.name.length));

    return Wrap(
      children: genres.map((Genre genre) => Chip(
        label: Text(genre.name),
      )).toList(),
      runSpacing: -8.0,
      spacing: 8.0,
    );
  }
}
