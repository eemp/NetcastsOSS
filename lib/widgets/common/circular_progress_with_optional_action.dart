import 'package:flutter/material.dart';

import 'package:percent_indicator/percent_indicator.dart';

class CircularProgressWithOptionalAction extends StatelessWidget {
  final Icon icon;
  final Function onPressed;
  final double progress;

  const CircularProgressWithOptionalAction({
    Key key,
    this.icon,
    this.onPressed,
    this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: CircularPercentIndicator(
        backgroundColor: progress == null
          ? Theme.of(context).scaffoldBackgroundColor
          : const Color(0xFFB8C7CB),
        center: icon,
        lineWidth: 3.0,
        percent: progress ?? 0.0,
        radius: 40.0,
        progressColor: Theme.of(context).accentColor,
      ),
      onTap: onPressed,
    );
  }
}
