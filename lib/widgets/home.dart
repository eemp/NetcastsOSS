import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:hear2learn/helpers/podcast.dart';
import 'package:hear2learn/models/podcast.dart';
import 'package:hear2learn/redux/state.dart';
import 'package:hear2learn/widgets/common/bottom_app_bar_player.dart';
import 'package:hear2learn/widgets/common/horizontal_list_view.dart';
import 'package:hear2learn/widgets/common/with_fade_in_image.dart';
import 'package:hear2learn/widgets/downloads/index.dart';
import 'package:hear2learn/widgets/podcast/index.dart';
import 'package:hear2learn/widgets/search/index.dart';
import 'package:hear2learn/widgets/settings/index.dart';
import 'package:hear2learn/widgets/subscriptions/index.dart';
import 'package:redux/redux.dart';

class Home extends StatefulWidget {
  @override
  State createState() => HomeState();
}

class HomeState extends State<Home> {
  List<Widget> homepageLists;

  @override
  void initState() {
    super.initState();
    init().then((List<Widget> results) {
      setState(() {
        homepageLists = results;
      });
    });
  }

  Future<List<Widget>> init() async {
    return <Widget>[
      buildSubscriptionsPreview(),
      buildHomepageList('Science', await searchPodcastsByGenre(1315)),
      buildHomepageList('Technology', await searchPodcastsByGenre(1318)),
      buildHomepageList('Comedy', await searchPodcastsByGenre(1303)),
      buildHomepageList('Business', await searchPodcastsByGenre(1321)),
    ];
  }

  Widget buildSubscriptionsPreview() {
    const int MAX_SHOWCASE_ITEMS = 12;
    return StoreConnector<AppState, List<Podcast>>(
      converter: (Store<AppState> store) => store.state.subscriptions,
      builder: (BuildContext context, List<Podcast> subscriptions) {
        return HomepageList(
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
          showcase: PodcastsShowcaseList(
            list: subscriptions,
            title: 'Your Podcasts',
          )
        );
      },
    );
  }

  Widget buildHomepageList(String title, List<Podcast> podcasts) {
    return HomepageList(
      showcase: PodcastsShowcaseList(
        list: podcasts,
        title: title,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: homepageLists != null
        ? ListView.separated(
          itemBuilder: (BuildContext context, int idx) {
            return homepageLists[idx];
          },
          itemCount: homepageLists.length,
          separatorBuilder: (BuildContext context, int index) => Divider(),
          shrinkWrap: true,
        )
        : Container(height: 0, width: 0),
      bottomNavigationBar: BottomAppBarPlayer(),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the Drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
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
                child: null,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(builder: (BuildContext context) => Home()),
                );
              },
              title: const Text('Home'),
            ),
            ListTile(
              leading: const Icon(Icons.explore),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(builder: (BuildContext context) => PodcastSearch()),
                );
              },
              title: const Text('Explore'),
            ),
            Divider(),
            ListTile(
              leading: const Icon(Icons.subscriptions),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(builder: (BuildContext context) => SubscriptionsPage()),
                );
              },
              title: const Text('Your Podcasts'),
            ),
            ListTile(
              leading: const Icon(Icons.get_app),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(builder: (BuildContext context) => DownloadPage()),
                );
              },
              title: const Text('Downloads'),
            ),
            Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(builder: (BuildContext context) => Settings()),
                );
              },
              title: const Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomepageList extends StatelessWidget {
  final Function onMoreClick;
  final PodcastsShowcaseList showcase;

  const HomepageList({
    Key key,
    this.onMoreClick,
    this.showcase,
  }) : super(key: key);

  bool isNotEmpty() {
    return showcase.list.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final List<HorizontalListTile> tiles = showcase.list?.map((Podcast podcast) {
      final Widget image = WithFadeInImage(
        heroTag: '${showcase.title}/${podcast.artwork600}',
        location: podcast.artwork600,
      );

      return HorizontalListTile(
        image: image,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(builder: (BuildContext context) => PodcastPage(
              image: image,
              podcast: podcast,
            )),
          );
        },
        title: podcast.name,
      );
    })?.toList() ?? <HorizontalListTile>[];

    return tiles.isNotEmpty
      ? HorizontalListViewCard(
        children: tiles,
        onMoreClick: onMoreClick,
        title: showcase.title,
      )
      : Container(height: 0.0, width: 0.0);
  }
}

class PodcastsShowcaseList {
  List<Podcast> list;
  String title;

  PodcastsShowcaseList({
    this.list,
    this.title,
  });

  static Future<PodcastsShowcaseList> toFuturePodcastsShowcaseList(String title, Future<List<Podcast>> futurePodcasts) {
    return futurePodcasts.then((List<Podcast> list) => PodcastsShowcaseList(
      list: list,
      title: title,
    ));
  }

  @override
  String toString() {
    return 'list: ${list.toString()}, title: $title';
  }
}
