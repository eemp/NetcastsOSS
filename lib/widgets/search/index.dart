import 'dart:async';
import 'package:flutter/material.dart';

import 'package:hear2learn/helpers/podcast.dart';
import 'package:hear2learn/models/podcast.dart';
import 'package:hear2learn/widgets/common/bottom_app_bar_player.dart';
import 'package:hear2learn/widgets/common/placeholder_screen.dart';
import 'package:hear2learn/widgets/common/vertical_list_view.dart';
import 'package:hear2learn/widgets/common/with_fade_in_image.dart';
import 'package:hear2learn/widgets/podcast/index.dart';

const int MAX_SHOWCASE_LIST_SIZE = 20;

class PodcastSearch extends StatefulWidget {
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
          style: const TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search, color: Colors.white),
            hintText: 'Search for podcasts...',
            hintStyle: const TextStyle(color: Colors.white)
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
            if(!snapshot.hasData) {
              return Container(
                child: const Center(child: CircularProgressIndicator()),
              );
            }

            return snapshot.data.isNotEmpty
              ? VerticalListView(
                children: snapshot.data.map((Podcast podcast) {
                  final Widget image = WithFadeInImage(
                    heroTag: 'search/${podcast.artwork600}',
                    location: podcast.artwork600,
                  );

                  return VerticalListTile(
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
                    //subtitle: podcast.description,
                    subtitle: podcast.getByline(),
                    title: podcast.name,
                  );
                }).toList(),
              )
              : PlaceholderScreen(
                icon: Icons.search,
                subtitle: 'Search for podcasts by keywords above.',
                title: 'No podcasts to show',
              );
          },
        ),
        padding: const EdgeInsets.all(16.0),
      ),
      bottomNavigationBar: BottomAppBarPlayer(),
    );
  }
}
