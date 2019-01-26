import 'package:flutter/material.dart';

import 'package:hear2learn/widgets/common/people.dart';
import 'package:hear2learn/widgets/common/tags.dart';

class PodcastInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          child: Text('People', style: Theme.of(context).textTheme.subhead),
          margin: const EdgeInsets.only(bottom: 16.0),
        ),
        Container(
          child: PeopleList(),
          margin: const EdgeInsets.only(bottom: 16.0),
        ),
        Container(
          child: Text('Topics', style: Theme.of(context).textTheme.subhead),
          margin: const EdgeInsets.only(bottom: 16.0),
        ),
        Container(
          child: Tags(),
          margin: const EdgeInsets.only(bottom: 16.0),
        ),
      ],
    );
  }
}
