import 'dart:async';
import 'package:flutter/material.dart';

import 'package:hear2learn/app.dart';
import 'package:hear2learn/widgets/common/bottom_app_bar_player.dart';
import 'package:hear2learn/widgets/common/toggling_widget_pair.dart';
import 'package:hear2learn/helpers/episode.dart' as episode_helpers;
import 'package:hear2learn/helpers/podcast.dart';
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/models/episode_download.dart';
import 'package:hear2learn/models/podcast.dart';
import 'package:hear2learn/models/podcast_subscription.dart';
import 'package:hear2learn/redux/actions.dart';
import 'package:hear2learn/widgets/podcast/episodes.dart';
import 'package:hear2learn/widgets/podcast/home.dart';
import 'package:hear2learn/services/feeds/podcast.dart';

class PodcastPage extends StatefulWidget {
  final bool directToEpisodes;
  final Widget image;
  final Podcast podcast;

  const PodcastPage({
    Key key,
    this.directToEpisodes = false,
    this.image,
    this.podcast,
  }) : super(key: key);

  @override
  PodcastPageState createState() => PodcastPageState();
}

class PodcastPageState extends State<PodcastPage> {
  final App app = App();

  bool get directToEpisodes => widget.directToEpisodes;
  Widget get image => widget.image;
  Podcast get podcast => widget.podcast;

  @override
  Widget build(BuildContext context) {
    final PodcastSubscriptionBean subscriptionModel = app.models['podcast_subscription'];

    final Future<Podcast> podcastFuture = getPodcastFromFeed(podcast: podcast).then(
      (Podcast podcast) => Future.wait(podcast.episodes.map((Episode episode) => episode.getDownload())).then(
        (List<EpisodeDownload> downloads) => Future<Podcast>.value(podcast)
      )
    );
    final Future<PodcastSubscription> podcastSubscriptionFuture = subscriptionModel.findOneWhere(subscriptionModel.podcastUrl.eq(podcast.feed))
      .then((PodcastSubscription response) => response ?? PodcastSubscription(isSubscribed: false));

    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          title: Text(podcast.name),
          bottom: TabBar(
            tabs: const <Widget>[
              Tab(
                icon: Icon(Icons.music_video),
                text: 'Podcast',
              ),
              Tab(
                icon: Icon(Icons.list),
                text: 'Episodes',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Container(
              child: PodcastHome(
                description: podcast.description,
                genres: podcast.genres,
                image: image,
              ),
              margin: const EdgeInsets.all(16.0),
            ),
            Container(
              child: buildPodcastEpisodesList(podcastFuture),
              margin: const EdgeInsets.all(16.0),
            ),
          ],
        ),
        bottomNavigationBar: const BottomAppBarPlayer(),
        floatingActionButton: buildSubscriptionButton(podcastSubscriptionFuture),
      ),
      initialIndex: directToEpisodes ? 1 : 0,
      length: 2,
    );
  }

  Widget buildSubscriptionButton(Future<PodcastSubscription> podcastSubscriptionFuture) {
    return FutureBuilder<PodcastSubscription>(
      future: podcastSubscriptionFuture,
      builder: (BuildContext context, AsyncSnapshot<PodcastSubscription> snapshot) {
        if(!snapshot.hasData) {
          return Container(width: 0.0, height: 0.0);
        }

        final TogglingWidgetPairController togglingWidgetPairController = TogglingWidgetPairController(
          value: snapshot.data?.isSubscribed == true
            ? TogglingWidgetPairValue.active
            : TogglingWidgetPairValue.initial,
        );

        return TogglingWidgetPair(
          controller: togglingWidgetPairController,
          activeWidget: FloatingActionButton.extended(
            icon: const Icon(Icons.remove),
            label: const Text('Unsubscribe'),
            onPressed: () async {
              await unsubscribeFromPodcast(podcast);
              togglingWidgetPairController.setInitialValue();
              app.store.dispatch(Action(
                type: ActionType.UPDATE_SUBSCRIPTIONS,
                payload: <String, dynamic>{
                  'subscriptions': await getSubscriptions(),
                },
              ));
            },
          ),
          initialWidget: FloatingActionButton.extended(
            icon: const Icon(Icons.add),
            label: const Text('Subscribe'),
            onPressed: () async {
              await subscribeToPodcast(podcast);
              togglingWidgetPairController.setActiveValue();
              app.store.dispatch(Action(
                type: ActionType.UPDATE_SUBSCRIPTIONS,
                payload: <String, dynamic>{
                  'subscriptions': await getSubscriptions(),
                },
              ));
            },
          ),
        );
      },
    );
  }

  Widget buildPodcastEpisodesList(Future<Podcast> podcastFuture) {
    return FutureBuilder<Podcast>(
      future: podcastFuture,
      builder: (BuildContext context, AsyncSnapshot<Podcast> snapshot) {
        if(!snapshot.hasData) {
          return Container(
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        return PodcastEpisodesList(
          onEpisodeDelete: episode_helpers.deleteEpisode,
          onEpisodeDownload: episode_helpers.downloadEpisode,
          episodes: snapshot.data.episodes,
        );
      },
    );
  }
}
