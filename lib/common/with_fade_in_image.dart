import 'dart:math';

import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class WithFadeInImage extends StatelessWidget {
  final List<String> availablePlaceholders = [
   'images/01--default-fadein-image.jpg',
   'images/02--default-fadein-image.jpg',
   'images/03--default-fadein-image.jpg',
   'images/04--default-fadein-image.jpg',
   'images/05--default-fadein-image.jpg',
   'images/06--default-fadein-image.jpg',
   'images/07--default-fadein-image.jpg',
   'images/08--default-fadein-image.jpg',
  ];
  final Random rng = new Random();

  String location;

  WithFadeInImage({
    Key key,
    this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int randIdx = rng.nextInt(availablePlaceholders.length);
    String randomPlaceholder = availablePlaceholders[randIdx];
    return FadeInImage.assetNetwork(
      fadeInDuration: Duration(milliseconds: 300),
      fit: BoxFit.fill,
      image: location,
      placeholder: randomPlaceholder,
      //placeholder: kTransparentImage,
    );
  }
}
