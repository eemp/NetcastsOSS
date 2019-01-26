import 'package:flutter/material.dart';

class PlaceholderScreen extends StatelessWidget {
  final IconData icon;
  final String subtitle;
  final String title;

  const PlaceholderScreen({
    Key key,
    this.icon,
    this.subtitle,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) => Stack(
          children: <Widget>[
            Center(
              child: Icon(icon, color: Colors.grey[200], size: constraints.biggest.width)
            ),
            Center(
              child: Column(
                children: <Widget>[
                  Text(title, style: Theme.of(context).textTheme.title),
                  Text(subtitle, style: Theme.of(context).textTheme.subtitle),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
