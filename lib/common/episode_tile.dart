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
      title: Text(title),
      subtitle: Text(subtitle),
      isThreeLine: true,
      leading: Container(
        child: image,
        constraints: new BoxConstraints(maxWidth: 64.0, minWidth: 64.0),
      ),
      trailing: options,
    );
  }
}

