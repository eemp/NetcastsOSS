import 'package:flutter/material.dart';

class VerticalListTile extends StatelessWidget {
  Image image;
  Widget subtitle;
  String title;
  double imageSize = 80.0;

  VerticalListTile({
    Key key,
    this.image,
    this.subtitle,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      leading: Container(
        child: image,
        constraints: BoxConstraints(maxWidth: imageSize, minWidth: imageSize),
      ),
      subtitle: subtitle,
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      )
    );
  }
}

class VerticalListView extends StatelessWidget {
  List<Widget> children;

  VerticalListView({
    Key key,
    this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      physics: PageScrollPhysics(),
      children: children,
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
    );
  }
}
