import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:hear2learn/app.dart';
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/redux/selectors.dart';
import 'package:hear2learn/redux/state.dart';
import 'package:hear2learn/widgets/common/bottom_app_bar_player.dart';
import 'package:hear2learn/widgets/common/episode_list.dart';
import 'package:hear2learn/widgets/common/placeholder_screen.dart';

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

          return EpisodesList(
            episodes: downloads,
          );
        },
      ),
      bottomNavigationBar: const BottomAppBarPlayer(),
    );
  }
}
