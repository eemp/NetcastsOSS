import 'package:flutter/material.dart';

class VerticalListTile extends StatelessWidget {
  final Widget image;
  final Function onTap;
  final String subtitle;
  final String title;

  const VerticalListTile({
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
        leading: image != null
          ? Container(
            child: image,
            height: 80.0,
            width: 80.0,
          )
          : null,
        subtitle: subtitle != null
          ? Text(subtitle, maxLines: 2, overflow: TextOverflow.ellipsis)
          : null,
        title: Text(title, maxLines: 2, overflow: TextOverflow.ellipsis),
      ),
    );
  }
}

class VerticalListView extends StatelessWidget {
  final List<Widget> children;

  const VerticalListView({
    Key key,
    this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: children.length,
      itemBuilder: (BuildContext context, int idx) {
        return children[idx];
      },
      separatorBuilder: (BuildContext context, int idx) => Divider(),
    );
  }
}
