import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';

class PodcastHome extends StatelessWidget {
  final String description;
  final Widget image;
  final Function onSubscribe;
  final Function onUnsubscribe;

  const PodcastHome({
    Key key,
    this.description,
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
          child: description != null ? Html(
            data: description,
            defaultTextStyle: Theme.of(context).textTheme.body1,
          ) : null,
          padding: const EdgeInsets.only(top: 16.0),
        ),
      ],
    );
  }
}
