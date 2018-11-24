import 'package:flutter/material.dart';

class EpisodeTile extends StatelessWidget {
  Image image;
  String subtitle;
  String title;
  Widget options;

  EpisodeTile({
    Key key,
    this.image,
    this.options,
    this.subtitle,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      //leading: Container(
        //child: image,
        //constraints: new BoxConstraints(maxWidth: 80.0, minWidth: 80.0),
      //),
      subtitle: Text(subtitle),
      title: Text(title, maxLines: 2, overflow: TextOverflow.ellipsis),
      trailing: options,
    );
  }
}

