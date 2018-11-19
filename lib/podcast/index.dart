import 'package:flutter/material.dart';
import 'package:swagger/api.dart';
import 'package:hear2learn/podcast/info.dart';
import 'package:hear2learn/podcast/episodes.dart';
import 'package:hear2learn/podcast/home.dart';

class PodcastPage extends StatelessWidget {
  String url;

  PodcastPage({
    Key key,
    this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var podcastApiService = new PodcastApi();
    var podcastFuture = podcastApiService.getPodcast(url);

    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          title: buildPodcastTitle(podcastFuture),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.music_video),
                text: 'Podcast',
              ),
              Tab(
                icon: Icon(Icons.list),
                text: 'Episodes',
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
              child: buildPodcastHome(podcastFuture),
              margin: EdgeInsets.all(16.0),
            ),
            Container(
              child: PodcastEpisodesList(),
              margin: EdgeInsets.all(16.0),
            ),
            Container(
              child: PodcastInfo(),
              margin: EdgeInsets.all(16.0),
            ),
          ],
        ),
      ),
      length: 3,
    );
  }

  Widget buildPodcastHome(Future<Podcast> podcastFuture) {
    return FutureBuilder(
      future: podcastFuture,
      builder: (BuildContext context, AsyncSnapshot<Podcast> snapshot) {
        return snapshot.hasData
          ? PodcastHome(
            description: snapshot.data.description.replaceAll("\n", " "),
            logo_url: snapshot.data.logoUrl,
          )
          : Padding(
            padding: EdgeInsets.all(32.0),
            child: Center(child: CircularProgressIndicator()),
          );
      },
    );
  }

  Widget buildPodcastTitle(Future<Podcast> podcastFuture) {
    return FutureBuilder(
      future: podcastFuture,
      builder: (BuildContext context, AsyncSnapshot<Podcast> snapshot) {
        return snapshot.hasData
          ? Text(snapshot.data.title)
          : Text('...');
      },
    );
  }
}
