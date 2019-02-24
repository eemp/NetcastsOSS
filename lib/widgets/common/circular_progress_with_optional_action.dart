import 'package:flutter/material.dart';

import 'package:hear2learn/helpers/dash.dart' as dash;
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
          ? Colors.transparent
          : const Color(0xFFB8C7CB),
        center: icon,
        lineWidth: 3.0,
        percent: dash.clamp(0.0, progress ?? 0.0, 1.0),
        radius: 40.0,
        progressColor: Theme.of(context).accentColor,
      ),
      onTap: onPressed,
    );
  }
}
