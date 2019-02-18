import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:hear2learn/app.dart';
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/redux/selectors.dart';
import 'package:hear2learn/redux/state.dart';
import 'package:hear2learn/widgets/common/bottom_app_bar_player.dart';
import 'package:hear2learn/widgets/common/episode_tile_connector.dart';
import 'package:hear2learn/widgets/common/placeholder_screen.dart';
import 'package:hear2learn/widgets/common/vertical_list_view.dart';

class FavoritePage extends StatelessWidget {
  final App app = App();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites')
      ),
      body: StoreConnector<AppState, List<Episode>>(
        converter: favoritesSelector,
        builder: (BuildContext context, List<Episode> favorites) {
          if(favorites.isEmpty) {
            return const PlaceholderScreen(
              icon: Icons.favorite_border,
              subtitle: 'Favorite episodes and manage them here.',
              title: 'No favorites available',
            );
          }

          return Container(
            child: VerticalListView(
              children: favorites.map((Episode episode) => EpisodeTileConnector(
                episode: episode,
                subtitleProvider: (Episode episode) => episode.podcastTitle,
              )).toList(),
            ),
            padding: const EdgeInsets.all(16.0),
          );
        },
      ),
      bottomNavigationBar: const BottomAppBarPlayer(),
    );
  }
}
