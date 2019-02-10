import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:hear2learn/constants.dart';
import 'package:hear2learn/helpers/podcast.dart';
import 'package:hear2learn/models/podcast.dart';
import 'package:hear2learn/redux/state.dart';
import 'package:hear2learn/widgets/common/bottom_app_bar_player.dart';
import 'package:hear2learn/widgets/common/drawer.dart';
import 'package:hear2learn/widgets/home/list.dart';
import 'package:hear2learn/widgets/subscriptions/index.dart';
import 'package:redux/redux.dart';

const String SCIENCE_GENRE_ID = '1315';
const String TECH_GENRE_ID = '1318';
const String COMEDY_GENRE_ID = '1303';
const String BUSINESS_GENRE_ID = '1321';

class Home extends StatelessWidget {
  final Future<List<Widget>> showcases = getHomepageLists();

  Home({
    Key key,
  }) : super(key: key);

  static Future<List<Widget>> getHomepageLists() async {
    return <Widget>[
      buildSubscriptionsPreview(),
      buildHomepageList('Science', await searchPodcastsByGenre(SCIENCE_GENRE_ID)),
      buildHomepageList('Technology', await searchPodcastsByGenre(TECH_GENRE_ID)),
      buildHomepageList('Comedy', await searchPodcastsByGenre(COMEDY_GENRE_ID)),
      buildHomepageList('Business', await searchPodcastsByGenre(BUSINESS_GENRE_ID)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: FutureBuilder<List<Widget>>(
        future: showcases,
        builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
          if(!snapshot.hasData) {
            return Container(
              child: const Center(child: CircularProgressIndicator()),
            );
          }

          return ListView.builder(
            itemBuilder: (BuildContext context, int idx) {
              return snapshot.data[idx];
            },
            itemCount: snapshot.data.length,
            shrinkWrap: true,
          );
        }
      ),
      bottomNavigationBar: const BottomAppBarPlayer(),
      drawer: AppDrawer(),
    );
  }

  static Widget buildSubscriptionsPreview() {
    const int MAX_SHOWCASE_ITEMS = 12;
    return StoreConnector<AppState, List<Podcast>>(
      converter: (Store<AppState> store) => store.state.subscriptions,
      builder: (BuildContext context, List<Podcast> subscriptions) {
        return HomepageList(
          list: subscriptions,
          onMoreClick: subscriptions.length > MAX_SHOWCASE_ITEMS
            ? () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => SubscriptionsPage(),
                ),
              );
            }
            : null,
          directToEpisodes: true,
          title: LIBRARY_LABEL,
        );
      },
    );
  }

  static Widget buildHomepageList(String title, List<Podcast> podcasts) {
    return HomepageList(
      list: podcasts,
      title: title,
    );
  }
}
