import 'package:flutter/material.dart';

class OutlineIconButton extends StatelessWidget {
  final IconData icon;
  final Function onPressed;
  final double size;

  const OutlineIconButton({
    Key key,
    this.icon,
    this.onPressed,
    this.size=20.0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      child: Icon(
         icon,
         size: size,
      ),
      constraints: BoxConstraints.tight(Size.fromRadius(size)),
      shape: CircleBorder(side: BorderSide(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.12))),
      elevation: 2.0,
    );
  }
}
