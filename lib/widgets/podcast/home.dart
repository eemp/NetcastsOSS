import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:hear2learn/models/podcast.dart';
import 'package:hear2learn/widgets/common/tags.dart';
import 'package:hear2learn/widgets/podcast/options.dart';

class PodcastHome extends StatelessWidget {
  final Widget image;
  final Function onShare;
  final Function onSubscribe;
  final Function onUnsubscribe;
  final Podcast podcast;

  String get description => podcast.description;
  List<Genre> get genres => podcast.genres;

  const PodcastHome({
    Key key,
    this.image,
    this.podcast,
    this.onShare,
    this.onSubscribe,
    this.onUnsubscribe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            child: image,
            height: MediaQuery.of(context).size.width - 64,
            width: MediaQuery.of(context).size.width - 32,
          ),
        ),
        Container(
          child: PodcastOptions(
            podcast: podcast,
            onShare: onShare,
            onSubscribe: onSubscribe,
            onUnsubscribe: onUnsubscribe,
          ),
          margin: const EdgeInsets.symmetric(vertical: 8.0),
        ),
        Container(
          child: description != null ? Html(
            data: description,
            defaultTextStyle: Theme.of(context).textTheme.body1,
          ) : null,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
        ),
        Container(
          child: Tags(
            genres: genres,
          ),
          margin: const EdgeInsets.symmetric(vertical: 8.0),
        ),
      ],
    );
  }
}
