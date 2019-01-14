import 'package:flutter/material.dart';

import 'package:hear2learn/widgets/episode/info.dart';
import 'package:hear2learn/widgets/episode/home.dart';
import 'package:hear2learn/helpers/episode.dart' as episodeHelpers;
import 'package:hear2learn/models/episode.dart';

class EpisodePage extends StatefulWidget {
  Episode episode;

  EpisodePage({
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
            tabs: [
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
          children: [
            Container(
              child: EpisodeHome(
                episode: episode,
                onEpisodeDelete: (episode) async {
                  await episodeHelpers.deleteEpisode(episode);
                  await episode.getDownload();
                  setState(() { /* force most of episode page to update - home, options, player */ });
                },
                onEpisodeDownload: (episode) async {
                  await episodeHelpers.downloadEpisode(episode);
                  await episode.getDownload();
                  setState(() { /* force most of episode page to update - home, options, player */ });
                },
              ),
              margin: EdgeInsets.all(16.0),
            ),
            Container(
              child: EpisodeInfo(
                episode: episode,
              ),
              margin: EdgeInsets.all(16.0),
            ),
          ],
        ),
      ),
      length: 2,
    );
  }
}
