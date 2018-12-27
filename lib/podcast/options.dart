import 'package:flutter/material.dart';

class PodcastOptions extends StatelessWidget {
  bool isSubscribed;

  PodcastOptions({
    Key key,
    this.isSubscribed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: IconButton(
            icon: Icon(isSubscribed ? Icons.done : Icons.library_add),
            iconSize: 24.0,
          ),
        ),
        Container(
          child: IconButton(
            icon: Icon(Icons.share),
            iconSize: 24.0,
          ),
        ),
      ],
    );
  }
}
