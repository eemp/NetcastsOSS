import 'package:flutter/material.dart';

class EpisodeTile extends StatelessWidget {
  final bool emphasis;
  final Image image;
  final bool isSelected;
  final String subtitle;
  final String title;
  final Function onLongPress;
  final Function onTap;
  final Widget options;

  const EpisodeTile({
    Key key,
    this.emphasis = false,
    this.image,
    this.isSelected = false,
    this.options,
    this.subtitle,
    this.title,
    this.onLongPress,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isSelected
        ? Theme.of(context).colorScheme.onSurface.withOpacity(0.12)
        : Theme.of(context).canvasColor,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        onLongPress: onLongPress,
        onTap: onTap,
        subtitle: Text(subtitle),
        title: Text(title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: emphasis
            ? const TextStyle(fontWeight: FontWeight.bold)
            : const TextStyle(fontWeight: FontWeight.normal),
        ),
        trailing: options,
      ),
    );
  }
}

