import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class WithFadeInImage extends StatelessWidget {
  String location;

  WithFadeInImage({
    Key key,
    this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      fadeInDuration: Duration(milliseconds: 300),
      fit: BoxFit.fill,
      image: location,
      placeholder: 'images/default-fadein-image.jpg',
      //placeholder: kTransparentImage,
    );
  }
}
