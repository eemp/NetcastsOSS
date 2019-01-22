import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:hear2learn/widgets/common/with_fade_in_image.dart';

class PodcastHome extends StatelessWidget {
  String description;
  Widget image;
  Function onSubscribe;
  Function onUnsubscribe;

  PodcastHome({
    Key key,
    this.description,
    this.image,
    this.onSubscribe,
    this.onUnsubscribe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
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
          padding: EdgeInsets.only(top: 16.0),
        ),
      ],
    );
  }
}
