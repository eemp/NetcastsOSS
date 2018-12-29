import 'package:flutter/material.dart';

import 'package:hear2learn/app.dart';
import 'package:hear2learn/common/vertical_list_view.dart';
import 'package:hear2learn/common/with_fade_in_image.dart';
import 'package:hear2learn/episode/index.dart';
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/models/episode_download.dart';

class DownloadPage extends StatelessWidget {
  final App app = App();

  @override
  Widget build(BuildContext context) {
    EpisodeDownloadBean downloadModel = app.models['episode_download'];
    Future<List<EpisodeDownload>> downloadsFuture = downloadModel.getAll();

    return Scaffold(
      appBar: AppBar(
        title: Text('Downloads')
      ),
      body: FutureBuilder(
        future: downloadsFuture,
        builder: (BuildContext context, AsyncSnapshot<List<EpisodeDownload>> snapshot) {
          return snapshot.hasData
            ? Container(
                child: VerticalListView(
                  children: snapshot.data.map((episodeDownload) {
                    Episode episode = episodeDownload.getEpisodeFromDetails();
                    return VerticalListTile(
                      //image: WithFadeInImage(location: podcast.scaledLogoUrl),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EpisodePage(
                            episode: episode,
                          )),
                        );
                      },
                      subtitle: episode.title,
                      title: episode.podcastTitle,
                    );
                  }).toList(),
                ),
                padding: EdgeInsets.all(16.0),
              )
            : Padding(
              padding: EdgeInsets.all(32.0),
              child: Center(child: CircularProgressIndicator()),
            );
        },
      ),
    );
  }
}
