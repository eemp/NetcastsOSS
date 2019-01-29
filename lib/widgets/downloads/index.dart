import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:hear2learn/app.dart';
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/redux/actions.dart';
import 'package:hear2learn/redux/selectors.dart';
import 'package:hear2learn/redux/state.dart';
import 'package:hear2learn/widgets/common/bottom_app_bar_player.dart';
import 'package:hear2learn/widgets/common/episode_tile.dart';
import 'package:hear2learn/widgets/common/placeholder_screen.dart';
import 'package:hear2learn/widgets/common/vertical_list_view.dart';
import 'package:hear2learn/widgets/episode/index.dart';

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
          return downloads.isNotEmpty
            ? Container(
                child: VerticalListView(
                  children: downloads.map((Episode episode) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(builder: (BuildContext context) => EpisodePage(episode: episode)),
                      );
                    },
                    child: EpisodeTile(
                      subtitle: episode.podcastTitle,
                      title: episode.title,
                      options: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          app.store.dispatch(deleteEpisode(episode));
                        },
                      ),
                    ),
                  )).toList(),
                ),
                padding: const EdgeInsets.all(16.0),
              )
              : const PlaceholderScreen(
                icon: Icons.get_app,
                subtitle: 'Download episodes and manage them here.',
                title: 'No downloads available',
              );
        },
      ),
      bottomNavigationBar: const BottomAppBarPlayer(),
    );
  }
}
