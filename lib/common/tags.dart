import 'package:flutter/material.dart';

class Tags extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Chip(
          backgroundColor: Theme.of(context).accentColor,
          label: Text('Current Affairs'),
        ),
        Chip(
          backgroundColor: Theme.of(context).accentColor,
          label: Text('News'),
        ),
        Chip(
          backgroundColor: Theme.of(context).accentColor,
          label: Text('Politics'),
        ),
        Chip(
          backgroundColor: Theme.of(context).accentColor,
          label: Text('Government'),
        ),
        Chip(
          backgroundColor: Theme.of(context).accentColor,
          label: Text('Satire'),
        ),
      ],
      runSpacing: -8.0,
      spacing: 8.0,
    );
  }
}
