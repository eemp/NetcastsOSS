import 'package:flutter/material.dart';

import 'package:hear2learn/app.dart';
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/models/podcast_subscription.dart';
import 'package:hear2learn/podcast/info.dart';
import 'package:hear2learn/podcast/episodes.dart';
import 'package:hear2learn/podcast/home.dart';
import 'package:swagger/api.dart';

class PodcastData {
  final Podcast podcast;
  final PodcastSubscription subscription;

  PodcastData({this.podcast, this.subscription});
}

class PodcastPage extends StatelessWidget {
  final App app = App();
  final PodcastApi podcastApiService = new PodcastApi();

  PodcastSubscriptionBean subscriptionModel;
  String url;

  PodcastPage({
    Key key,
    this.url,
  }) : super(key: key) {
    subscriptionModel = app.models['podcast_subscription'];
  }

  @override
  Widget build(BuildContext context) {
    Future<Podcast> podcastFuture = podcastApiService.getPodcast(url);
    Future<PodcastSubscription> podcastSubscriptionFuture = subscriptionModel.findOneWhere(subscriptionModel.podcastUrl.eq(url));

    Future<PodcastData> podcastWithSubscriptionFuture = Future.wait([podcastFuture, podcastSubscriptionFuture])
      .then((response) => new PodcastData(podcast: response[0], subscription: response[1]));

    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          title: buildPodcastTitle(podcastWithSubscriptionFuture),
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
              child: buildPodcastHome(podcastWithSubscriptionFuture),
              margin: EdgeInsets.all(16.0),
            ),
            Container(
              child: PodcastEpisodesList(podcastUrl: url),
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

  Widget buildPodcastTitle(podcastWithSubscriptionFuture) {
    return FutureBuilder(
      future: podcastWithSubscriptionFuture,
      builder: (BuildContext context, AsyncSnapshot<PodcastData> snapshot) {
        return snapshot.hasData
          ? Text(snapshot.data.podcast.title)
          : Text('...');
      },
    );
  }

  Widget buildPodcastHome(podcastWithSubscriptionFuture) {
    return FutureBuilder(
      future: podcastWithSubscriptionFuture,
      builder: (BuildContext context, AsyncSnapshot<PodcastData> snapshot) {
        return snapshot.hasData
          ? PodcastHome(
            description: snapshot.data.podcast.description.replaceAll("\n", " "),
            isSubscribed: snapshot.data.subscription?.isSubscribed ?? false,
            onSubscribe: () async {
              await subscriptionModel.insert(PodcastSubscription(
                created: DateTime.now(),
                isSubscribed: true,
                lastUpdated: DateTime.now(),
                podcastUrl: url,
              ));
            },
            onUnsubscribe: () async {
              Map<String, dynamic> update = new Map<String, dynamic>();
              update[subscriptionModel.isSubscribed.name] = false;
              update[subscriptionModel.lastUpdated.name] = DateTime.now();
              await subscriptionModel.updateFields(subscriptionModel.podcastUrl.eq(url), update);
            },
            logo_url: snapshot.data.podcast.logoUrl,
          )
          : Padding(
            padding: EdgeInsets.all(32.0),
            child: Center(child: CircularProgressIndicator()),
          );
      },
    );
  }
}
