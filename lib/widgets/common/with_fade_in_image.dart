import 'dart:math';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:hear2learn/helpers/dash.dart' as dash;

class WithFadeInImage extends StatelessWidget {
  final List<String> availablePlaceholders = <String>[
   'images/01--default-fadein-image.jpg',
   'images/02--default-fadein-image.jpg',
   'images/03--default-fadein-image.jpg',
   'images/04--default-fadein-image.jpg',
   'images/05--default-fadein-image.jpg',
   'images/06--default-fadein-image.jpg',
   'images/07--default-fadein-image.jpg',
   'images/08--default-fadein-image.jpg',
  ];
  final Random rng = Random();

  final String heroTag;
  final String location;

  WithFadeInImage({
    Key key,
    this.location,
    this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int randIdx = rng.nextInt(availablePlaceholders.length);
    final String randomPlaceholder = availablePlaceholders[randIdx];

    final Widget image = Image(
      fit: BoxFit.cover,
      image: dash.isNotEmpty(location)
        ? CachedNetworkImageProvider(location)
        : AssetImage(randomPlaceholder),
    );

    return heroTag != null
      ? Hero(
        tag: heroTag,
        child: image,
      )
      : image
    ;
  }
}
