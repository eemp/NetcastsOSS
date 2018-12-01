import 'package:flutter/material.dart';
import 'package:hear2learn/episode/info.dart';
import 'package:hear2learn/episode/home.dart';
import 'package:hear2learn/models/episode.dart';

class EpisodePage extends StatelessWidget {
  Episode episode;

  EpisodePage({
    Key key,
    this.episode,
  }) : super(key: key);

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


