import 'package:flutter/material.dart';

class HorizontalListTile extends StatelessWidget {
  Image image;
  String title;

  HorizontalListTile({
    Key key,
    this.image,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: image,
          ),
          Flexible(
            child: Container(
              child: Text(title, maxLines: 2, overflow: TextOverflow.ellipsis),
              padding: EdgeInsets.only(top: 8.0),
            ),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      width: 130.0,
    );
  }
}

class HorizontalListView extends StatelessWidget {
  List<Widget> children;

  HorizontalListView({
    Key key,
    this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      physics: PageScrollPhysics(),
      children: children,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
    );
  }
}

class HorizontalListViewCard extends StatelessWidget {
  List<Widget> children;
  String title;

  HorizontalListViewCard({
    Key key,
    this.children,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  Text(title, style: Theme.of(context).textTheme.subhead),
                  Text('MORE', style: TextStyle(color: Theme.of(context).accentColor, fontWeight: FontWeight.bold)),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            ),
            Container(
              child: HorizontalListView(
                children: children,
              ),
              height: 200.0,
            ),
          ],
        ),
      ),
      height: 246.0,
      margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
    );
  }
}
