import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:hear2learn/models/episode.dart';

class EpisodeInfo extends StatelessWidget {
  final Episode episode;

  const EpisodeInfo({
    Key key,
    this.episode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
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
            defaultTextStyle: Theme.of(context).textTheme.body1,
          ),
          padding: const EdgeInsets.only(bottom: 16.0),
        ),
        //Container(
          //child: Text('Topics', style: Theme.of(context).textTheme.subhead),
          //margin: const EdgeInsets.only(bottom: 16.0),
        //),
        //Container(
          //child: Tags(),
          //margin: const EdgeInsets.only(bottom: 16.0),
        //),
      ],
    );
  }
}
