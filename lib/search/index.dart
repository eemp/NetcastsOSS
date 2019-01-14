import 'package:flutter/material.dart';
import 'package:swagger/api.dart';

import 'package:hear2learn/common/bottom_app_bar_player.dart';
import 'package:hear2learn/common/vertical_list_view.dart';
import 'package:hear2learn/common/with_fade_in_image.dart';
import 'package:hear2learn/podcast/index.dart';

const MAX_SHOWCASE_LIST_SIZE = 20;
var podcastApiService = new PodcastApi();

class PodcastSearch extends StatefulWidget {
  @override
  PodcastSearchState createState() => new PodcastSearchState();
}

class PodcastSearchState extends State<PodcastSearch> {
  final globalKey = new GlobalKey<ScaffoldState>();

  final TextEditingController inputController = new TextEditingController();
  FocusNode inputFocus;
  String userQuery = '';

  Future <List<Podcast>> results = podcastApiService.getTopPodcasts(MAX_SHOWCASE_LIST_SIZE, scaleLogo: 200);

  @override
  void initState() {
    super.initState();

    inputFocus = FocusNode();
    userQuery = '';

    results = podcastApiService.getTopPodcasts(MAX_SHOWCASE_LIST_SIZE, scaleLogo: 200);
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
          style: new TextStyle(
            color: Colors.white,
          ),
          decoration: new InputDecoration(
            prefixIcon: new Icon(Icons.search, color: Colors.white),
            hintText: "Search for podcasts...",
            hintStyle: new TextStyle(color: Colors.white)
          ),
          onChanged: (text) {
            setState(() {
              userQuery = text;
            });
          },
          onSubmitted: (text) {
            setState(() {
              userQuery = text;
              results = podcastApiService.searchPodcasts(userQuery, scaleLogo: 200);
            });
          },
        ),
        actions: !userQuery.isEmpty
          ? [
            IconButton(
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: () {
                setState(() {
                  userQuery = '';
                  results = podcastApiService.getTopPodcasts(MAX_SHOWCASE_LIST_SIZE, scaleLogo: 200);
                });
                inputController.clear();
                FocusScope.of(context).requestFocus(inputFocus);
              },
            ),
          ]
          : [],
      ),
      body: Container(
        child: FutureBuilder(
          future: results,
          builder: (BuildContext context, AsyncSnapshot<List<Podcast>> snapshot) {
            return snapshot.hasData
              ? VerticalListView(
                children: snapshot.data.map((podcast) {
                  Widget image = WithFadeInImage(
                    heroTag: 'search/${podcast.logoUrl}',
                    location: podcast.logoUrl,
                  );

                  return VerticalListTile(
                    image: WithFadeInImage(location: podcast.scaledLogoUrl),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PodcastPage(
                          image: image,
                          logoUrl: podcast.logoUrl,
                          url: podcast.url,
                        )),
                      );
                    },
                    subtitle: podcast.description,
                    title: podcast.title,
                  );
                }).toList(),
              )
              : Padding(
                padding: EdgeInsets.all(32.0),
                child: Center(child: CircularProgressIndicator()),
              );
          },
        ),
        padding: EdgeInsets.all(16.0),
      ),
      bottomNavigationBar: BottomAppBarPlayer(),
    );
  }
}


