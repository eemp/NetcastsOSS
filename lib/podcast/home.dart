import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:hear2learn/common/with_fade_in_image.dart';

class PodcastHome extends StatelessWidget {
  String description;
  String logo_url;

  PodcastHome({
    Key key,
    this.description,
    this.logo_url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          child: WithFadeInImage(
            location: logo_url,
          ),
          padding: const EdgeInsets.only(bottom: 16.0),
        ),
        Container(
          child: Html(
            data: description,
          ),
          padding: const EdgeInsets.only(bottom: 16.0),
        ),
      ],
    );
  }
}
