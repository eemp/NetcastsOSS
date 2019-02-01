import 'package:flutter/material.dart';

class PlayerOptionWithProgress extends StatelessWidget {
  final Icon icon;
  final Function onPressed;
  final double progress;

  const PlayerOptionWithProgress({
    Key key,
    this.icon,
    this.onPressed,
    this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: CircularProgressIndicator(
            strokeWidth: 3.0,
            value: progress,
          ),
        ),
        IconButton(
          highlightColor: Colors.transparent,
          icon: icon,
          onPressed: onPressed,
          splashColor: Colors.transparent,
        ),
      ],
    );
  }
}
