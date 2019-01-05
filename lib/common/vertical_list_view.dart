import 'package:flutter/material.dart';

class VerticalListTile extends StatelessWidget {
  Widget image;
  Function onTap;
  String subtitle;
  String title;

  VerticalListTile({
    Key key,
    this.image,
    this.onTap,
    this.subtitle,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
        leading: image != null
          ? Container(
            child: image,
            height: 80.0,
            width: 80.0,
          )
          : null,
        subtitle: Text(
          subtitle, maxLines: 2, overflow: TextOverflow.ellipsis,
        ),
        title: Text(title),
      ),
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
    return ListView.separated(
      itemCount: children.length,
      itemBuilder: (context, idx) {
        return children[idx];
      },
      separatorBuilder: (context, idx) => Divider(),
    );
  }
}
