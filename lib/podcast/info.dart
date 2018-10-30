import 'package:flutter/material.dart';

import 'package:hear2learn/common/people.dart';
import 'package:hear2learn/common/tags.dart';

class PodcastInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          child: Text('People', style: Theme.of(context).textTheme.subhead),
          margin: const EdgeInsets.all(16.0),
        ),
        Container(
          child: PeopleList(),
          margin: const EdgeInsets.all(16.0),
        ),
        Container(
          child: Text('Topics', style: Theme.of(context).textTheme.subhead),
          margin: const EdgeInsets.all(16.0),
        ),
        Container(
          child: Tags(),
          margin: const EdgeInsets.all(16.0),
        ),
      ],
    );
  }
}
