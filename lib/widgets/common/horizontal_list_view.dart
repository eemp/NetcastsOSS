import 'package:flutter/material.dart';

class HorizontalListTile extends StatelessWidget {
  final Widget image;
  final Function onTap;
  final String title;

  const HorizontalListTile({
    Key key,
    this.image,
    this.onTap,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: image,
              height: 100.0,
              width: 100.0,
            ),
            Flexible(
              child: Container(
                child: Text(title, maxLines: 2, overflow: TextOverflow.ellipsis),
                padding: const EdgeInsets.only(top: 8.0),
              ),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        width: 110.0,
      ),
    );
  }
}

class HorizontalListView extends StatelessWidget {
  final List<Widget> children;

  const HorizontalListView({
    Key key,
    this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      physics: const PageScrollPhysics(),
      children: children,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
    );
  }
}

class HorizontalListViewCard extends StatelessWidget {
  final List<Widget> children;
  final String title;
  final Function onMoreClick;

  const HorizontalListViewCard({
    Key key,
    this.children,
    this.onMoreClick,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Text(title, style: Theme.of(context).textTheme.subhead),
                onMoreClick != null ? InkWell(
                  child: Text('MORE', style: Theme.of(context).textTheme.button),
                  onTap: onMoreClick,
                ) : Container(height: 0.0, width: 0.0),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
          ),
          Container(
            child: HorizontalListView(
              children: children,
            ),
            height: 175.0,
          ),
        ],
      ),
    );
  }
}
