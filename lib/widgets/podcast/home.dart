import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:hear2learn/models/podcast.dart';
import 'package:hear2learn/widgets/common/tags.dart';

class PodcastHome extends StatelessWidget {
  final String description;
  final List<Genre> genres;
  final Widget image;
  final Function onSubscribe;
  final Function onUnsubscribe;

  const PodcastHome({
    Key key,
    this.description,
    this.genres,
    this.image,
    this.onSubscribe,
    this.onUnsubscribe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          child: image,
          height: MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.width,
        ),
        Container(
          child: Tags(
            genres: genres,
          ),
          margin: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        ),
        Container(
          child: description != null ? Html(
            data: description,
            defaultTextStyle: Theme.of(context).textTheme.body1,
          ) : null,
        ),
      ],
    );
  }
}
