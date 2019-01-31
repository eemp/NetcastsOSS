import 'dart:async';
import 'package:flutter/material.dart';

import 'package:hear2learn/app.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/models/podcast.dart';
import 'package:hear2learn/redux/actions.dart';
import 'package:hear2learn/redux/selectors.dart';
import 'package:hear2learn/redux/state.dart';
import 'package:hear2learn/widgets/common/bottom_app_bar_player.dart';
import 'package:hear2learn/widgets/podcast/episodes.dart';
import 'package:hear2learn/widgets/podcast/home.dart';
import 'package:hear2learn/services/feeds/podcast.dart';

// ignore: must_be_immutable
class PodcastPage extends StatelessWidget {
  final bool directToEpisodes;
  final Widget image;
  final Podcast podcast;
  Future<Podcast> completePodcastFuture;

  PodcastPage({
    Key key,
    this.directToEpisodes = false,
    this.image,
    this.podcast,
  }) : super(key: key) {
    completePodcastFuture = getPodcastFromFeed(podcast: podcast);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          title: Text(podcast.name),
          bottom: const TabBar(
            tabs: <Widget>[
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
              child: buildPodcastEpisodesList(),
              margin: const EdgeInsets.all(16.0),
            ),
          ],
        ),
        bottomNavigationBar: const BottomAppBarPlayer(),
        floatingActionButton: buildSubscriptionButton(),
      ),
      initialIndex: directToEpisodes ? 1 : 0,
      length: 2,
    );
  }

  Widget buildSubscriptionButton() {
    final App app = App();

    return StoreConnector<AppState, Podcast>(
      converter: getSubscriptionSelector(podcast),
      builder: (BuildContext context, Podcast subscription) {
        final bool isSubscribed = subscription != null;

        return !isSubscribed
          ? FloatingActionButton.extended(
            icon: const Icon(Icons.add),
            label: const Text('Subscribe'),
            onPressed: () async {
              app.store.dispatch(subscribeToPodcast(podcast));
            },
          )
          : FloatingActionButton.extended(
            icon: const Icon(Icons.remove),
            label: const Text('Unsubscribe'),
            onPressed: () async {
              app.store.dispatch(unsubscribeFromPodcast(podcast));
            },
          );
      },
    );
  }

  Widget buildPodcastEpisodesList() {
    final App app = App();

    return FutureBuilder<Podcast>(
      future: completePodcastFuture,
      builder: (BuildContext context, AsyncSnapshot<Podcast> snapshot) {
        if(!snapshot.hasData) {
          return Container(
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        return PodcastEpisodesList(
          onEpisodeDelete: (Episode episode) {
            app.store.dispatch(deleteEpisode(episode));
          },
          onEpisodeDownload: (Episode episode) {
            app.store.dispatch(downloadEpisode(episode));
          },
          episodes: snapshot.data.episodes,
        );
      },
    );
  }
}
