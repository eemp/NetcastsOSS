import 'package:flutter/material.dart';

import 'package:hear2learn/widgets/episode/info.dart';
import 'package:hear2learn/widgets/episode/home.dart';
import 'package:hear2learn/helpers/episode.dart' as episode_helpers;
import 'package:hear2learn/models/episode.dart';

class EpisodePage extends StatefulWidget {
  final Episode episode;

  const EpisodePage({
    Key key,
    this.episode,
  }) : super(key: key);

  @override
  EpisodePageState createState() => EpisodePageState();
}

class EpisodePageState extends State<EpisodePage> {
  Episode get episode => widget.episode;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Episode of ' + episode.podcastTitle),
          bottom: TabBar(
            tabs: const <Widget>[
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
                onEpisodeDelete: (Episode episode) async {
                  await episode_helpers.deleteEpisode(episode);
                  await episode.getDownload();
                  setState(() { /* force most of episode page to update - home, options, player */ });
                },
                onEpisodeDownload: (Episode episode) async {
                  await episode_helpers.downloadEpisode(episode);
                  await episode.getDownload();
                  setState(() { /* force most of episode page to update - home, options, player */ });
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
