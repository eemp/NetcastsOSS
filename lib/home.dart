import 'package:flutter/material.dart';
import 'package:swagger/api.dart';

import 'package:hear2learn/app.dart';
import 'package:hear2learn/common/horizontal_list_view.dart';
import 'package:hear2learn/downloads/index.dart';
import 'package:hear2learn/episode/index.dart';
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/models/podcast_subscription.dart';
import 'package:hear2learn/podcast/index.dart';
import 'package:hear2learn/search/index.dart';
import 'package:hear2learn/settings/index.dart';
import 'package:hear2learn/subscriptions/index.dart';

const MAX_SHOWCASE_LIST_SIZE = 20;

class Home extends StatelessWidget {
  final App app = App();
  final PodcastApi podcastApiService = new PodcastApi();

  @override
  Widget build(BuildContext context) {
    const titles = [ 'Your Podcasts', 'Top Podcasts', 'New', 'Trending', 'Recommended' ];
    Future<List<Podcast>> toplistFuture = podcastApiService.getTopPodcasts(MAX_SHOWCASE_LIST_SIZE, scaleLogo: 200);

    PodcastSubscriptionBean subscriptionModel = app.models['podcast_subscription'];
    Future<List<Podcast>> subscriptionsFuture = subscriptionModel.findWhere(subscriptionModel.isSubscribed.eq(true)).then((response) {
      return Future.wait(response.map((subscription) => podcastApiService.getPodcast(subscription.podcastUrl)));
    });

    List<Future<List<Podcast>>> homepageLists = [
      subscriptionsFuture,
      toplistFuture,
      toplistFuture,
      toplistFuture,
      toplistFuture,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int idx) {
          return buildHorizontalList(homepageLists[idx], title: titles[idx], debugWithShuffle: idx > 0);
        },
        itemCount: 5,
        separatorBuilder: (context, index) => Divider(),
        shrinkWrap: true,
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the Drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            Container(
              child: DrawerHeader(
                //child: Text('Hear2Learn'),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: ExactAssetImage('images/drawer-header--balloons.jpg'),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
              title: Text('Home'),
            ),
            ListTile(
              leading: Icon(Icons.explore),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PodcastSearch()),
                );
              },
              title: Text('Explore'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.apps),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SubscriptionsPage()),
                );
              },
              title: Text('Your Podcasts'),
            ),
            ListTile(
              leading: Icon(Icons.subscriptions),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DownloadPage()),
                );
              },
              title: Text('Downloads'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Settings()),
                );
              },
              title: Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHorizontalList(Future<List<Podcast>> toplistFuture, {String title, bool debugWithShuffle = false}) {
    return FutureBuilder(
      future: toplistFuture,
      builder: (BuildContext context, AsyncSnapshot<List<Podcast>> snapshot) {
        List<HorizontalListTile> tiles = snapshot.hasData
          ? snapshot.data.map((podcast) =>
            HorizontalListTile(
              image: podcast.scaledLogoUrl,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PodcastPage(
                    url: podcast.url,
                  )),
                );
              },
              title: podcast.title,
            )
          ).toList()
          : [];

        // TODO: REMOVE - temporary MOCK data
        if(debugWithShuffle) {
          tiles.shuffle();
        }

        return tiles.length > 0
          ? HorizontalListViewCard(
            children: tiles,
            onMoreClick: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SubscriptionsPage()),
              );
            },
            title: title != null ? title : 'Top Podcasts',
          )
          : Container(width: 0.0, height: 0.0);
      },
    );
  }
}

