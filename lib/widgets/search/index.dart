import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter_pagewise/flutter_pagewise.dart';
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
  String userQuery = '';

  Future<List<Podcast>> results;

  @override
  void initState() {
    super.initState();

    inputFocus = FocusNode();
    userQuery = '';

    results = Future<List<Podcast>>.value(<Podcast>[]);
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed
    inputFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          controller: inputController,
          focusNode: inputFocus,
          key: Key('podcastSearch'),
          style: const TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(userQuery.isEmpty ? Icons.search : Icons.trending_flat, color: Colors.white),
            hintText: 'Search for podcasts...',
            hintStyle: TextStyle(color: Colors.white)
          ),
          onChanged: (String text) {
            setState(() {
              userQuery = text;
            });
          },
          onSubmitted: (String text) {
            setState(() {
              userQuery = text;
              results = searchPodcastsByTextQuery(userQuery);
            });
          },
        ),
        actions: userQuery.isNotEmpty
          ? <Widget>[
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {
                setState(() {
                  results = searchPodcastsByTextQuery(userQuery);
                });
              },
              tooltip: 'Search for Podcasts',
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () {
                setState(() {
                  userQuery = '';
                  results = Future<List<Podcast>>.value(<Podcast>[]);
                });
                inputController.clear();
                FocusScope.of(context).requestFocus(inputFocus);
              },
            ),
          ]
          : <Widget>[],
      ),
      body: Container(
        child: FutureBuilder<List<Podcast>>(
          future: results,
          builder: (BuildContext context, AsyncSnapshot<List<Podcast>> snapshot) {
            if(snapshot.hasError) {
              return const PlaceholderScreen(
                icon: Icons.error_outline,
                subtitle: 'Unable to search podcasts. Please check your connectivity or try again later.',
                title: 'No podcasts to show',
              );
            }
            if(!snapshot.hasData) {
              return Container(
                child: const Center(child: CircularProgressIndicator()),
              );
            }
            if(snapshot.data.isEmpty) {
              return const PlaceholderScreen(
                icon: Icons.search,
                subtitle: 'Search for podcasts by keywords above.',
                title: 'No podcasts to show',
              );
            }

            return PagewiseListView<Podcast>(
              pageSize: 10,
              itemBuilder: (BuildContext context, Podcast podcast, int index) {
                final Widget image = WithFadeInImage(
                  heroTag: 'search/${podcast.artwork600}',
                  location: podcast.artwork600,
                );

                return Column(
                  children: <Widget>[
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          child: image,
                          width: 80.0,
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
                    ),
                    const Divider(),
                  ],
                );
              },
              pageFuture: (int pageIndex) {
                return searchPodcastsByTextQuery(userQuery, page: pageIndex);
              },
            );
          },
        ),
        padding: const EdgeInsets.all(16.0),
      ),
      bottomNavigationBar: const BottomAppBarPlayer(),
    );
  }
}
