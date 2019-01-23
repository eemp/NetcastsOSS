import 'package:flutter/material.dart';

import 'package:hear2learn/helpers/podcast.dart';
import 'package:hear2learn/models/podcast.dart';
import 'package:hear2learn/widgets/common/bottom_app_bar_player.dart';
import 'package:hear2learn/widgets/common/vertical_list_view.dart';
import 'package:hear2learn/widgets/common/with_fade_in_image.dart';
import 'package:hear2learn/widgets/podcast/index.dart';

const MAX_SHOWCASE_LIST_SIZE = 20;

class PodcastSearch extends StatefulWidget {
  @override
  PodcastSearchState createState() => new PodcastSearchState();
}

class PodcastSearchState extends State<PodcastSearch> {
  final globalKey = new GlobalKey<ScaffoldState>();

  final TextEditingController inputController = new TextEditingController();
  FocusNode inputFocus;
  String userQuery = '';

  Future<List<Podcast>> results;

  @override
  void initState() {
    super.initState();

    inputFocus = FocusNode();
    userQuery = '';

    results = Future.value(new List<Podcast>());
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
              results = searchPodcastsByTextQuery(userQuery);
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
                  results = Future.value(new List<Podcast>());
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
                    heroTag: 'search/${podcast.artwork600}',
                    location: podcast.artwork600,
                  );

                  return VerticalListTile(
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
                    //subtitle: podcast.description,
                    subtitle: podcast.getByline(),
                    title: podcast.name,
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
