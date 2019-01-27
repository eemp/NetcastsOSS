import 'package:flutter/material.dart';

import 'package:hear2learn/models/podcast.dart';
import 'package:hear2learn/widgets/common/horizontal_list_view.dart';
import 'package:hear2learn/widgets/common/with_fade_in_image.dart';
import 'package:hear2learn/widgets/podcast/index.dart';

class HomepageList extends StatelessWidget {
  final List<Podcast> list;
  final Function onMoreClick;
  final String title;

  const HomepageList({
    Key key,
    this.list,
    this.onMoreClick,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<HorizontalListTile> tiles = list?.map((Podcast podcast) {
      final Widget image = WithFadeInImage(
        heroTag: '$title/${podcast.artwork600}',
        location: podcast.artwork600,
      );

      return HorizontalListTile(
        image: image,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(builder: (BuildContext context) => PodcastPage(
              image: image,
              podcast: podcast,
            )),
          );
        },
        title: podcast.name,
      );
    })?.toList() ?? <HorizontalListTile>[];

    return tiles.isNotEmpty
      ? HorizontalListViewCard(
        children: tiles,
        onMoreClick: onMoreClick,
        title: title,
      )
      : Container(height: 0.0, width: 0.0);
  }
}
