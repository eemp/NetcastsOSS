import 'package:flutter/material.dart';

class PlaceholderScreen extends StatelessWidget {
  final IconData icon;
  final String subtitle;
  final String title;

  PlaceholderScreen({
    Key key,
    this.icon,
    this.subtitle,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LayoutBuilder(
        builder: (context, constraint) => Stack(
          children: [
            Center(
              child: Icon(icon, color: Colors.grey[200], size: constraint.biggest.width)
            ),
            Center(
              child: Column(
                children: [
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
