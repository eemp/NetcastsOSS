import 'package:flutter/material.dart';
import 'package:hear2learn/common/circle_button.dart';
import 'package:hear2learn/episode/info.dart';
import 'package:hear2learn/episode/home.dart';

class Episode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Twice Removed'),
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
              child: EpisodeHome(),
              margin: EdgeInsets.all(16.0),
            ),
            Container(
              child: EpisodeInfo(),
              margin: EdgeInsets.all(16.0),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.replay_10),
                iconSize: 35.0,
              ),
              IconButton(
                icon: Icon(Icons.play_arrow),
                iconSize: 50.0,
              ),
              IconButton(
                icon: Icon(Icons.forward_30),
                iconSize: 35.0,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
        ),
      ),
      length: 2,
    );
  }
}


