import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:hear2learn/common/with_fade_in_image.dart';
import 'package:hear2learn/podcast/options.dart';

class PodcastHome extends StatelessWidget {
  String description;
  Widget image;
  bool isSubscribed;
  String logo_url;
  Function onSubscribe;
  Function onUnsubscribe;

  PodcastHome({
    Key key,
    this.description,
    this.image,
    this.isSubscribed,
    this.logo_url,
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
        //Container(
          //child: PodcastOptions(
            //isSubscribed: isSubscribed,
            //onSubscribe: onSubscribe,
            //onUnsubscribe: onUnsubscribe
          //),
        //),
        Container(
          child: description != null ? Html(
            data: description,
          ) : null,
          padding: EdgeInsets.only(top: 16.0),
        ),
      ],
    );
  }
}
