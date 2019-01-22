import 'package:flutter/material.dart';

import 'package:hear2learn/app.dart';
import 'package:hear2learn/helpers/podcast.dart';
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/models/podcast.dart';
import 'package:hear2learn/models/podcast_subscription.dart';
import 'package:hear2learn/services/api/elastic.dart';
import 'package:hear2learn/widgets/common/bottom_app_bar_player.dart';
import 'package:hear2learn/widgets/common/horizontal_list_view.dart';
import 'package:hear2learn/widgets/common/with_fade_in_image.dart';
import 'package:hear2learn/widgets/downloads/index.dart';
import 'package:hear2learn/widgets/episode/index.dart';
import 'package:hear2learn/widgets/podcast/index.dart';
import 'package:hear2learn/widgets/search/index.dart';
import 'package:hear2learn/widgets/settings/index.dart';
import 'package:hear2learn/widgets/subscriptions/index.dart';

const MAX_SHOWCASE_LIST_SIZE = 20;

class Home extends StatelessWidget {
  final App app = App();

  @override
  Widget build(BuildContext context) {
    PodcastSubscriptionBean subscriptionModel = app.models['podcast_subscription'];
    Future<List<Podcast>> subscriptionsFuture = subscriptionModel.findWhere(subscriptionModel.isSubscribed.eq(true)).then((response) {
      return Future.wait(response.map((subscription) => Future.value(subscription.getPodcastFromDetails())));
    });

    Future<List<Podcast>> topScienceCastsFuture = searchPodcastsByGenre(1315);
    Future<List<Podcast>> topTechCastsFuture = searchPodcastsByGenre(1318);
    Future<List<Podcast>> topComedyCastsFuture = searchPodcastsByGenre(1303);
    Future<List<Podcast>> topBusinessCastsFuture = searchPodcastsByGenre(1321);



    var homepageLists = [
      { 'list': subscriptionsFuture, 'title': 'Your Podcasts' },
      { 'list': topScienceCastsFuture, 'title': 'Science' },
      { 'list': topTechCastsFuture, 'title': 'Technology' },
      { 'list': topComedyCastsFuture, 'title': 'Comedy' },
      { 'list': topBusinessCastsFuture, 'title': 'Business' },
      //toplistFuture,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int idx) {
          return buildHorizontalList(homepageLists[idx]['list'], title: homepageLists[idx]['title']);
        },
        itemCount: homepageLists.length,
        separatorBuilder: (context, index) => Divider(),
        shrinkWrap: true,
      ),
      bottomNavigationBar: BottomAppBarPlayer(),
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

  Widget buildHorizontalList(Future<List<Podcast>> toplistFuture, {String title}) {
    return FutureBuilder(
      future: toplistFuture,
      builder: (BuildContext context, AsyncSnapshot<List<Podcast>> snapshot) {
        List<HorizontalListTile> tiles = snapshot.hasData
          ? snapshot.data.map((podcast) {
            Widget image = WithFadeInImage(
              heroTag: '${title}/${podcast.artwork600}',
              location: podcast.artwork600,
            );

            return HorizontalListTile(
              image: image,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PodcastPage(
                    image: image,
                    podcast: podcast,
                  )),
                );
              },
              title: podcast.name,
            );
          }).toList()
          : [];

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

