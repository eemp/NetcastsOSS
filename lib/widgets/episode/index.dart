import 'package:flutter/material.dart';

import 'package:hear2learn/app.dart';
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/redux/actions.dart';
import 'package:hear2learn/widgets/episode/info.dart';
import 'package:hear2learn/widgets/episode/home.dart';

class EpisodePage extends StatelessWidget {
  final Episode episode;

  const EpisodePage({
    Key key,
    this.episode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final App app = App();

    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Episode of ' + episode.podcastTitle),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.music_video),
                text: 'Episode',
              ),
              Tab(
                icon: Icon(Icons.info),
                text: 'Info',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Container(
              child: EpisodeHome(
                episode: episode,
                onEpisodeDelete: (Episode episode) {
                  app.store.dispatch(deleteEpisode(episode));
                },
                onEpisodeDownload: (Episode episode) {
                  app.store.dispatch(downloadEpisode(episode));
                },
              ),
              margin: const EdgeInsets.all(16.0),
            ),
            Container(
              child: EpisodeInfo(
                episode: episode,
              ),
              margin: const EdgeInsets.all(16.0),
            ),
          ],
        ),
      ),
      length: 2,
    );
  }
}
