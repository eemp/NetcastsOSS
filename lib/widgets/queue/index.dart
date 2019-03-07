import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:hear2learn/app.dart';
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/redux/selectors.dart';
import 'package:hear2learn/redux/state.dart';
import 'package:hear2learn/widgets/common/bottom_app_bar_player.dart';
import 'package:hear2learn/widgets/common/episode_list.dart';
import 'package:hear2learn/widgets/common/placeholder_screen.dart';

class QueuedListPage extends StatelessWidget {
  static const String routeName = 'QueuedListPage';

  final App app = App();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Queue')
      ),
      body: StoreConnector<AppState, List<Episode>>(
        converter: queueSelector,
        builder: (BuildContext context, List<Episode> queue) {
          if(queue.isEmpty) {
            return const PlaceholderScreen(
              icon: Icons.get_app,
              subtitle: 'Queue episodes via podcast episode list or downloads page, and manage them here.',
              title: 'No queue selected yet',
            );
          }

          return EpisodesList(
            episodes: queue,
          );
        },
      ),
      bottomNavigationBar: const BottomAppBarPlayer(),
    );
  }
}
