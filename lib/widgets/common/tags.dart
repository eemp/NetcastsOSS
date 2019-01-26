import 'package:flutter/material.dart';

class Tags extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Chip(
          backgroundColor: Theme.of(context).accentColor,
          label: const Text('Current Affairs'),
        ),
        Chip(
          backgroundColor: Theme.of(context).accentColor,
          label: const Text('News'),
        ),
        Chip(
          backgroundColor: Theme.of(context).accentColor,
          label: const Text('Politics'),
        ),
        Chip(
          backgroundColor: Theme.of(context).accentColor,
          label: const Text('Government'),
        ),
        Chip(
          backgroundColor: Theme.of(context).accentColor,
          label: const Text('Satire'),
        ),
      ],
      runSpacing: -8.0,
      spacing: 8.0,
    );
  }
}
