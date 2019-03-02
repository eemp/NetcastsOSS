import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:hear2learn/app.dart';
import 'package:hear2learn/models/podcast.dart';
import 'package:hear2learn/redux/actions.dart';
import 'package:hear2learn/redux/selectors.dart';
import 'package:hear2learn/redux/state.dart';
import 'package:hear2learn/widgets/common/bottom_app_bar_player.dart';
import 'package:hear2learn/widgets/common/placeholder_screen.dart';
import 'package:hear2learn/widgets/podcast/episodes.dart';
import 'package:hear2learn/widgets/podcast/home.dart';
import 'package:hear2learn/services/feeds/podcast.dart';
import 'package:share/share.dart';

// ignore: must_be_immutable
class PodcastPage extends StatelessWidget {
  static const String routeName = 'PodcastPage';

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
                image: image,
                onShare: onShare,
                onSubscribe: onSubscribe,
                onUnsubscribe: onUnsubscribe,
                podcast: podcast,
              ),
              margin: const EdgeInsets.all(16.0),
            ),
            Container(
              child: buildPodcastEpisodesList(),
            ),
          ],
        ),
        bottomNavigationBar: const BottomAppBarPlayer(),
        //floatingActionButton: buildSubscriptionButton(),
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
            backgroundColor: Theme.of(context).accentColor,
            icon: const Icon(Icons.add),
            label: const Text('Subscribe'),
            onPressed: () async {
              app.store.dispatch(subscribeToPodcast(podcast));
            },
          )
          : FloatingActionButton.extended(
            backgroundColor: Theme.of(context).accentColor,
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
    return FutureBuilder<Podcast>(
      future: completePodcastFuture,
      builder: (BuildContext context, AsyncSnapshot<Podcast> snapshot) {
        if(!snapshot.hasData) {
          return Container(
            child: const Center(child: CircularProgressIndicator()),
          );
        }
        if(snapshot.hasError) {
          return const PlaceholderScreen(
            icon: Icons.error_outline,
            subtitle: 'Unable to fetch episodes. Please check your connectivity or try again later.',
            title: 'No episodes to show',
          );
        }

        return PodcastEpisodesList(
          episodes: snapshot.data.episodes,
        );
      },
    );
  }

  void onShare() {
    Share.share('Check out ${podcast.name} podcast, courtesy of ${podcast.artist.name}');
  }

  void onSubscribe() {
    final App app = App();
    app.store.dispatch(subscribeToPodcast(podcast));
  }

  void onUnsubscribe() {
    final App app = App();
    app.store.dispatch(unsubscribeFromPodcast(podcast));
  }
}
