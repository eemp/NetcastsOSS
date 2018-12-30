import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:hear2learn/common/people.dart';
import 'package:hear2learn/common/tags.dart';
import 'package:hear2learn/models/episode.dart';

class EpisodeInfo extends StatelessWidget {
  Episode episode;

  EpisodeInfo({
    Key key,
    this.episode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        //Container(
          //child: Text('People', style: Theme.of(context).textTheme.subhead),
          //margin: const EdgeInsets.only(bottom: 16.0),
        //),
        //Container(
          //child: PeopleList(),
          //margin: const EdgeInsets.only(bottom: 16.0),
        //),
        Container(
          child: Text('Description', style: Theme.of(context).textTheme.subhead),
          margin: const EdgeInsets.only(bottom: 16.0),
        ),
        Container(
          child: Html(
            data: episode.description,
          ),
          padding: EdgeInsets.only(bottom: 16.0),
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
