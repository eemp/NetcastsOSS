import 'dart:io';
import 'package:flutter/material.dart';

import 'package:hear2learn/app.dart';
import 'package:hear2learn/common/bottom_app_bar_player.dart';
import 'package:hear2learn/common/toggling_widget_pair.dart';
import 'package:hear2learn/helpers/episode.dart' as episodeHelpers;
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/models/podcast.dart';
import 'package:hear2learn/models/podcast_subscription.dart';
import 'package:hear2learn/widgets/podcast/info.dart';
import 'package:hear2learn/widgets/podcast/episodes.dart';
import 'package:hear2learn/widgets/podcast/home.dart';
import 'package:hear2learn/services/feeds/podcast.dart';

class PodcastData {
  final Podcast podcast;
  final PodcastSubscription subscription;

  PodcastData({this.podcast, this.subscription});
}

class PodcastPage extends StatefulWidget {
  Widget image;
  String logoUrl;
  String title;
  String url;

  PodcastPage({
    Key key,
    this.image,
    this.logoUrl,
    this.title,
    this.url,
  }) : super(key: key);

  @override
  PodcastPageState createState() => PodcastPageState();
}

class PodcastPageState extends State<PodcastPage> {
  final App app = App();

  Widget get image => widget.image;
  String get logoUrl => widget.logoUrl;
  String get title => widget.title;
  String get url => widget.url;

  @override
  Widget build(BuildContext context) {
    PodcastSubscriptionBean subscriptionModel = app.models['podcast_subscription'];

    Future<Podcast> podcastFuture = getPodcastFromFeed(url).then(
      (podcast) => Future.wait(podcast.episodes.map((episode) => episode.getDownload())).then(
        (res) => Future.value(podcast)
      )
    );
    Future<PodcastSubscription> podcastSubscriptionFuture = subscriptionModel.findOneWhere(subscriptionModel.podcastUrl.eq(url));
    Future<PodcastData> podcastWithSubscriptionFuture = Future.wait([podcastFuture, podcastSubscriptionFuture])
      .then((response) => new PodcastData(podcast: response[0], subscription: response[1]));

    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
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
              child: buildPodcastEpisodesList(podcastFuture),
              margin: EdgeInsets.all(16.0),
            ),
            //Container(
              //child: PodcastInfo(),
              //margin: EdgeInsets.all(16.0),
            //),
          ],
        ),
        bottomNavigationBar: BottomAppBarPlayer(),
        floatingActionButton: buildSubscriptionButton(podcastWithSubscriptionFuture),
      ),
      length: 3,
    );
  }

  void onSubscribe() async {
    PodcastSubscriptionBean subscriptionModel = app.models['podcast_subscription'];
    PodcastSubscription newSubscription = new PodcastSubscription(
      created: DateTime.now(),
      isSubscribed: true,
      podcastUrl: url,
    );
    await subscriptionModel.insert(newSubscription);
  }

  void onUnsubscribe() async {
    PodcastSubscriptionBean subscriptionModel = app.models['podcast_subscription'];
    await subscriptionModel.removeWhere(subscriptionModel.podcastUrl.eq(url));
  }

  Widget buildPodcastHome(podcastWithSubscriptionFuture) {
    PodcastSubscriptionBean subscriptionModel = app.models['podcast_subscription'];
    return FutureBuilder(
      future: podcastWithSubscriptionFuture,
      builder: (BuildContext context, AsyncSnapshot<PodcastData> snapshot) {
        if(!snapshot.hasData) {
          return logoUrl != null
            ? PodcastHome(
              image: image,
              logo_url: logoUrl,
            )
            : Padding(
              padding: EdgeInsets.all(32.0),
              child: Center(child: CircularProgressIndicator()),
            )
          ;
        }

        return PodcastHome(
          description: snapshot.data.podcast.description.replaceAll("\n", " "),
          image: image,
          isSubscribed: snapshot.data.subscription?.isSubscribed ?? false,
          logo_url: snapshot.data.podcast.logoUrl,
        );
      },
    );
  }

  Widget buildSubscriptionButton(podcastWithSubscriptionFuture) {
    return FutureBuilder(
      future: podcastWithSubscriptionFuture,
      builder: (BuildContext context, AsyncSnapshot<PodcastData> snapshot) {
        TogglingWidgetPairController togglingWidgetPairController = TogglingWidgetPairController(
          value: snapshot.data?.subscription?.isSubscribed == true
            ? TogglingWidgetPairValue.active
            : TogglingWidgetPairValue.initial,
        );

        if(!snapshot.hasData) {
          return Container(width: 0.0, height: 0.0);
        }

        return TogglingWidgetPair(
          controller: togglingWidgetPairController,
          activeWidget: FloatingActionButton.extended(
            icon: Icon(Icons.remove),
            label: Text('Unsubscribe'),
            onPressed: () async {
              await this.onUnsubscribe();
              togglingWidgetPairController.setInitialValue();
            },
          ),
          initialWidget: FloatingActionButton.extended(
            icon: Icon(Icons.add),
            label: Text('Subscribe'),
            onPressed: () async {
              await this.onSubscribe();
              togglingWidgetPairController.setActiveValue();
            },
          ),
        );
      },
    );
  }

  Widget buildPodcastEpisodesList(podcastFuture) {
    return FutureBuilder(
      future: podcastFuture,
      builder: (BuildContext context, AsyncSnapshot<Podcast> snapshot) {
        return snapshot.hasData
          ? PodcastEpisodesList(
            onEpisodeDelete: episodeHelpers.deleteEpisode,
            onEpisodeDownload: episodeHelpers.downloadEpisode,
            episodes: snapshot.data.episodes,
          )
          : Padding(
            padding: EdgeInsets.all(32.0),
            child: Center(child: CircularProgressIndicator()),
          );
      },
    );
  }
}
