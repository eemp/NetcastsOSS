/*
 * taken from https://stackoverflow.com/a/50524531/3326617
 */
import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final double size;
  final GestureTapCallback onTap;
  final Icon icon;

  const CircleButton({
    Key key,
    this.icon,
    this.onTap,
    this.size=64.0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
        child: icon,
      ),
    );
  }
}
