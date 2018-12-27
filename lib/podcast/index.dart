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

class PodcastPage extends StatefulWidget {
  String url;

  PodcastPage({
    Key key,
    this.url,
  }) : super(key: key);

  @override
  PodcastPageState createState() => PodcastPageState();
}

class PodcastPageState extends State<PodcastPage> {
  final App app = App();
  final PodcastApi podcastApiService = new PodcastApi();

  bool isSubscribed;

  @override
  Widget build(BuildContext context) {
    PodcastSubscriptionBean subscriptionModel = app.models['podcast_subscription'];

    Future<Podcast> podcastFuture = podcastApiService.getPodcast(widget.url);
    Future<PodcastSubscription> podcastSubscriptionFuture = subscriptionModel.findOneWhere(subscriptionModel.podcastUrl.eq(widget.url));
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
              //Tab(
                //icon: Icon(Icons.info),
                //text: 'Info',
              //),
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
              child: PodcastEpisodesList(podcastUrl: widget.url),
              margin: EdgeInsets.all(16.0),
            ),
            //Container(
              //child: PodcastInfo(),
              //margin: EdgeInsets.all(16.0),
            //),
          ],
        ),
        floatingActionButton: buildSubscriptionButton(podcastWithSubscriptionFuture),
      ),
      length: 3,
    );
  }

  void onSubscribe() async {
    PodcastSubscriptionBean subscriptionModel = app.models['podcast_subscription'];
    await subscriptionModel.insert(PodcastSubscription(
      created: DateTime.now(),
      isSubscribed: true,
      podcastUrl: widget.url,
    ));
  }

  void onUnsubscribe() async {
    PodcastSubscriptionBean subscriptionModel = app.models['podcast_subscription'];
    await subscriptionModel.removeWhere(subscriptionModel.podcastUrl.eq(widget.url));
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
    PodcastSubscriptionBean subscriptionModel = app.models['podcast_subscription'];
    return FutureBuilder(
      future: podcastWithSubscriptionFuture,
      builder: (BuildContext context, AsyncSnapshot<PodcastData> snapshot) {
        return snapshot.hasData
          ? PodcastHome(
            description: snapshot.data.podcast.description.replaceAll("\n", " "),
            isSubscribed: snapshot.data.subscription?.isSubscribed ?? false,
            logo_url: snapshot.data.podcast.logoUrl,
          )
          : Padding(
            padding: EdgeInsets.all(32.0),
            child: Center(child: CircularProgressIndicator()),
          );
      },
    );
  }

  Widget buildSubscriptionButton(podcastWithSubscriptionFuture) {
    return FutureBuilder(
      future: podcastWithSubscriptionFuture,
      builder: (BuildContext context, AsyncSnapshot<PodcastData> snapshot) {
        bool isCurrentlySubscribed = isSubscribed ?? snapshot.data?.subscription?.isSubscribed ?? false;
        bool willBeSubscribed = !isCurrentlySubscribed;

        return snapshot.hasData ? FloatingActionButton.extended(
          icon: Icon(isCurrentlySubscribed ? Icons.remove : Icons.add),
          label: Text(isCurrentlySubscribed ? 'Unsubscribe' : 'Subscribe'),
          onPressed: () async {
            if(willBeSubscribed) {
              await this.onSubscribe();
            }
            else {
              await this.onUnsubscribe();
            }

            setState(() {
              isSubscribed = willBeSubscribed;
            });
          },
          tooltip: 'Subscribe',
        ) : new Container(width: 0.0, height: 0.0);
      },
    );
  }
}
