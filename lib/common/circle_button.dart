/*
 * taken from https://stackoverflow.com/a/50524531/3326617
 */
import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  double size;
  GestureTapCallback onTap;
  Icon icon;

  CircleButton({
    Key key,
    this.icon,
    this.onTap,
    this.size=64.0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new InkResponse(
      onTap: onTap,
      child: new Container(
        width: size,
        height: size,
        decoration: new BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
        child: icon,
      ),
    );
  }
}
