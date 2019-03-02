import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:hear2learn/app.dart';
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/redux/actions.dart';
import 'package:hear2learn/redux/selectors.dart';
import 'package:hear2learn/redux/state.dart';
import 'package:hear2learn/widgets/common/circular_progress_with_optional_action.dart';
import 'package:hear2learn/widgets/episode/index.dart';

class BottomAppBarPlayer extends StatelessWidget {
  final String mode;

  const BottomAppBarPlayer({
    Key key,
    this.mode = 'default',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final App app = App();

    return StoreConnector<AppState, Episode>(
      converter: playingEpisodeSelector,
      builder: (BuildContext context, Episode episode) {
        return episode != null
          ? BottomAppBar(
            child: ListTile(
              leading: CircularProgressWithOptionalAction(
                icon: episode.isPlaying()
                  ? const Icon(Icons.pause)
                  : const Icon(Icons.play_arrow),
                onPressed: () {
                  if(episode.isPlaying()) {
                    app.store.dispatch(pauseEpisode(episode));
                  }
                  else {
                    app.store.dispatch(playEpisode(episode));
                  }
                },
                progress: (episode.position?.inSeconds?.toDouble() ?? 0)
                  / (episode.length?.inSeconds?.toDouble() ?? 1),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => EpisodePage(episode: episode),
                    settings: const RouteSettings(name: EpisodePage.routeName),
                  ),
                );
              },
              subtitle: Text(episode.podcastTitle),
              title: Text(episode.title, overflow: TextOverflow.ellipsis),
            ),
          )
        : Container(height: 0.0, width: 0.0)
        ;
      },
    );
  }
}
