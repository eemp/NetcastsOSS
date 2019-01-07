import 'package:flutter/material.dart';
import 'package:swagger/api.dart';

import 'package:hear2learn/common/vertical_list_view.dart';
import 'package:hear2learn/common/with_fade_in_image.dart';
import 'package:hear2learn/podcast/index.dart';
import 'package:hear2learn/services/api/itunes_search.dart';

const MAX_SHOWCASE_LIST_SIZE = 20;
var podcastApiService = new PodcastApi();

class PodcastSearch extends StatefulWidget {
  @override
  PodcastSearchState createState() => new PodcastSearchState();
}

class PodcastSearchState extends State<PodcastSearch> {
  final globalKey = new GlobalKey<ScaffoldState>();
  final ITunesSearchAPI itunes = new ITunesSearchAPI();

  final TextEditingController inputController = new TextEditingController();
  FocusNode inputFocus;
  String userQuery = '';

  Future <List<ITunesSearchAPIResult>> results;

  @override
  void initState() {
    super.initState();

    inputFocus = FocusNode();
    userQuery = '';

    results = Future.value(new List<ITunesSearchAPIResult>());
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
              results = itunes.search(userQuery);
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
                  results = Future.value(new List<ITunesSearchAPIResult>());
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
          builder: (BuildContext context, AsyncSnapshot<List<ITunesSearchAPIResult>> snapshot) {
            return snapshot.hasData
              ? VerticalListView(
                children: snapshot.data.map((podcast) {
                  Widget image = WithFadeInImage(
                    heroTag: 'search/${podcast.artworkUrl}',
                    location: podcast.artworkUrl,
                  );

                  return VerticalListTile(
                    image: image,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PodcastPage(
                          image: image,
                          logoUrl: podcast.artworkUrl,
                          url: podcast.feedUrl,
                        )),
                      );
                    },
                    //subtitle: podcast.description,
                    subtitle: podcast.artistName != podcast.collectionName
                      ? 'by ${podcast.artistName}, ${podcast.trackCount.toString()} total episodes'
                      : '${podcast.trackCount.toString()} total episodes',
                    title: podcast.collectionName,
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
    );
  }
}
