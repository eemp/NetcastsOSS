import 'package:flutter/material.dart';

class EpisodeTile extends StatelessWidget {
  final bool emphasis;
  final Image image;
  final String subtitle;
  final String title;
  final Widget options;

  const EpisodeTile({
    Key key,
    this.emphasis = false,
    this.image,
    this.options,
    this.subtitle,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      subtitle: Text(subtitle),
      title: Text(title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: emphasis
          ? const TextStyle(fontWeight: FontWeight.bold)
          : const TextStyle(fontWeight: FontWeight.normal),
      ),
      trailing: options,
    );
  }
}

