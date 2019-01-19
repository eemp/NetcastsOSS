import 'package:flutter/material.dart';
import 'package:hear2learn/widgets/common/with_fade_in_image.dart';

class HorizontalListTile extends StatelessWidget {
  Widget image;
  Function onTap;
  String title;

  HorizontalListTile({
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
          children: [
            Container(
              child: image,
              height: 100.0,
              width: 100.0,
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
        width: 110.0,
      ),
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
  Function onMoreClick;

  HorizontalListViewCard({
    Key key,
    this.children,
    this.onMoreClick,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Text(title, style: Theme.of(context).textTheme.subhead),
                InkWell(
                  child: Text('MORE', style: TextStyle(color: Theme.of(context).accentColor, fontWeight: FontWeight.bold)),
                  onTap: onMoreClick,
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
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
