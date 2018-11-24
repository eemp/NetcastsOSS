import 'package:flutter/material.dart';
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
          //child: Image.network(
            //logo_url,
            //fit: BoxFit.cover,
          //),
          padding: const EdgeInsets.only(bottom: 16.0),
        ),
        Container(
          child: Text(
            description,
            softWrap: true,
            style: Theme.of(context).textTheme.body1,
          ),
          padding: const EdgeInsets.only(bottom: 16.0),
        ),
      ],
    );
  }
}
