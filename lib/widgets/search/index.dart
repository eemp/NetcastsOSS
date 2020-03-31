import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:hear2learn/helpers/dash.dart' as dash;
import 'package:hear2learn/helpers/podcast.dart';
import 'package:hear2learn/models/podcast.dart';
import 'package:hear2learn/widgets/common/bottom_app_bar_player.dart';
import 'package:hear2learn/widgets/common/placeholder_screen.dart';
import 'package:hear2learn/widgets/common/with_fade_in_image.dart';
import 'package:hear2learn/widgets/podcast/index.dart';

const int MAX_SHOWCASE_LIST_SIZE = 20;

class PodcastSearch extends StatefulWidget {
  static const String routeName = 'PodcastSearch';

  @override
  PodcastSearchState createState() => PodcastSearchState();
}

class PodcastSearchState extends State<PodcastSearch> {
  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  final TextEditingController inputController = TextEditingController();
  FocusNode inputFocus;
  int timestamp = new DateTime.now().millisecondsSinceEpoch;
  String userQuery = '';

  PagewiseLoadController<Podcast> get pageLoadController => PagewiseLoadController<Podcast>(
    pageSize: 10,
    pageFuture: (int pageIndex) {
      return searchPodcastsByTextQuery(userQuery, page: pageIndex);
    },
  );

  @override
  void initState() {
    super.initState();

    inputFocus = FocusNode();
    timestamp = new DateTime.now().millisecondsSinceEpoch;
    userQuery = '';
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed
    inputFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Function debouncedStateUpdate = dash.debounce((updatedUserQuery) {
      setState(() {
        userQuery = updatedUserQuery;
        timestamp = new DateTime.now().millisecondsSinceEpoch;
      });
    }, Duration(milliseconds: 800));

    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          controller: inputController,
          focusNode: inputFocus,
          key: const Key('podcastSearch'),
          style: const TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(userQuery.isEmpty ? Icons.search : Icons.trending_flat, color: Colors.white),
            hintText: 'Search for podcasts...',
            hintStyle: const TextStyle(color: Colors.white)
          ),
          onChanged: (String text) {
            debouncedStateUpdate([text]);
          },
          onSubmitted: (String text) {
            setState(() {
              userQuery = text;
              timestamp = new DateTime.now().millisecondsSinceEpoch;
            });
          },
        ),
        actions: userQuery.isNotEmpty
          ? <Widget>[
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {
                setState(() {
                  timestamp = new DateTime.now().millisecondsSinceEpoch;
                });
              },
              tooltip: 'Search for Podcasts',
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () {
                setState(() {
                  userQuery = '';
                  timestamp = new DateTime.now().millisecondsSinceEpoch;
                });
                inputController.clear();
                FocusScope.of(context).requestFocus(inputFocus);
              },
            ),
          ]
          : <Widget>[],
      ),
      body: Container(
        child: PagewiseListView<Podcast>(
          // pageSize: 10,
          itemBuilder: (BuildContext context, Podcast podcast, int index) {
            final Widget image = WithFadeInImage(
              heroTag: 'search/${podcast.artwork600}',
              location: podcast.artwork600,
            );
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                  child: image,
                  width: 64.0,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => PodcastPage(
                      image: image,
                      podcast: podcast,
                    ),
                    settings: const RouteSettings(name: PodcastPage.routeName),
                  ),
                );
              },
              subtitle: Text(podcast.getByline(), maxLines: 2, overflow: TextOverflow.ellipsis),
              title: Text(podcast.name, maxLines: 1, overflow: TextOverflow.ellipsis),
            );
          },
          loadingBuilder: (context) {
            return Container(
              child: const Center(child: CircularProgressIndicator()),
            );
          },
          noItemsFoundBuilder: (context) {
            return Container(
              // height: MediaQuery.of(context).size.height - kToolbarHeight,
              child: PlaceholderScreen(
                // icon: Icons.search,
                subtitle: 'Search for podcasts by keywords above.',
                title: 'No podcasts to show',
              )
            );
          },
          pageLoadController: pageLoadController,
          retryBuilder: (context, callback) {
            return Container(
              // height: MediaQuery.of(context).size.height - kToolbarHeight,
              child: PlaceholderScreen(
                // icon: Icons.search,
                subtitle: 'Service unavailable at this time - try again later.',
                title: 'No podcasts to show',
              )
            );
          },
        ),
        padding: const EdgeInsets.all(16.0),
      ),
      bottomNavigationBar: const BottomAppBarPlayer(),
    );
  }
}
