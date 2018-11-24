import 'package:flutter/material.dart';
import 'package:swagger/api.dart';

import 'package:hear2learn/common/horizontal_list_view_card.dart';
import 'package:hear2learn/subscriptions/index.dart';
import 'package:hear2learn/episode/index.dart';
import 'package:hear2learn/podcast/index.dart';
import 'package:hear2learn/podcast_search/index.dart';

const MAX_SHOWCASE_LIST_SIZE = 20;

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var podcastApiService = new PodcastApi();
    var toplistFuture = podcastApiService.getTopPodcasts(MAX_SHOWCASE_LIST_SIZE, scaleLogo: 200);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: ListView(
        children: [
          buildToplist(toplistFuture, title: 'Favorites'),
          buildToplist(toplistFuture),
        ],
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
                child: Text('Debug Menu'),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            ListTile(
              title: Text('Homepage'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
            ),
            ListTile(
              title: Text('Your Podcasts'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SubscriptionsPage()),
                );
              },
            ),
            ListTile(
              title: Text('Podcast Page'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PodcastPage(
                    url: 'http://feeds.feedburner.com/thetimferrissshow'
                    //url: 'http://feeds.feedburner.com/StartupsForTheRestOfUs'
                  )),
                );
              },
            ),
            ListTile(
              title: Text('Episode Page'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Episode()),
                );
              },
            ),
            ListTile(
              title: Text('Podcast Search Page'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PodcastSearch()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildToplist(Future<List<Podcast>> toplistFuture, {String title}) {
    return FutureBuilder(
      future: toplistFuture,
      builder: (BuildContext context, AsyncSnapshot<List<Podcast>> snapshot) {
        return HorizontalListViewCard(
          title: title != null ? title : 'Top Podcasts',
          children: snapshot.hasData
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
            : [],
        );
      },
    );
  }
}

