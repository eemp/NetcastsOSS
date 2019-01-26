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

  Color getIconColorWithContext(BuildContext context) {
    final Brightness brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark
      ? Colors.grey[900]
      : Colors.grey[200]
      ;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) => Stack(
          children: <Widget>[
            Center(
              child: Icon(icon, color: getIconColorWithContext(context), size: constraints.biggest.width)
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
