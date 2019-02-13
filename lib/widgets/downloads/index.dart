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

class DownloadPage extends StatelessWidget {
  final App app = App();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Downloads')
      ),
      body: StoreConnector<AppState, List<Episode>>(
        converter: downloadsSelector,
        builder: (BuildContext context, List<Episode> downloads) {
          if(downloads.isEmpty) {
            return const PlaceholderScreen(
              icon: Icons.get_app,
              subtitle: 'Download episodes and manage them here.',
              title: 'No downloads available',
            );
          }

          return Container(
            child: VerticalListView(
              children: downloads.map((Episode episode) => EpisodeTileConnector(
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
