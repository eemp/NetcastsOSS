import 'dart:async';
import 'package:flutter/material.dart';

import 'package:hear2learn/app.dart';
import 'package:hear2learn/widgets/common/bottom_app_bar_player.dart';
import 'package:hear2learn/widgets/common/episode_tile.dart';
import 'package:hear2learn/widgets/common/placeholder_screen.dart';
import 'package:hear2learn/widgets/common/vertical_list_view.dart';
import 'package:hear2learn/widgets/episode/index.dart';
import 'package:hear2learn/helpers/episode.dart' as episode_helpers;
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/models/episode_download.dart';

class DownloadPage extends StatefulWidget {
  @override
  DownloadPageState createState() => DownloadPageState();
}

class DownloadPageState extends State<DownloadPage> {
  final App app = App();
  Future<List<Episode>> downloadsFuture;

  @override
  Widget build(BuildContext context) {
    final EpisodeDownloadBean downloadModel = app.models['episode_download'];
    downloadsFuture = downloadModel.getAll().then((List<EpisodeDownload> downloads) {
      return downloads.map((EpisodeDownload download) => download.getEpisodeFromDetails()).toList();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Downloads')
      ),
      body: FutureBuilder<List<Episode>>(
        future: downloadsFuture,
        builder: (BuildContext context, AsyncSnapshot<List<Episode>> snapshot) {
          if(!snapshot.hasData) {
            return Container(
              child: const Center(child: CircularProgressIndicator()),
            );
          }

          return snapshot.data.isNotEmpty
            ? Container(
                child: VerticalListView(
                  children: snapshot.data.map((Episode episode) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(builder: (BuildContext context) => EpisodePage(episode: episode)),
                      );
                    },
                    child: EpisodeTile(
                      subtitle: episode.podcastTitle,
                      title: episode.title,
                      options: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          await episode_helpers.deleteEpisode(episode);
                          setState(() {
                            downloadsFuture = downloadModel.getAll().then((List<EpisodeDownload> downloads) {
                              return downloads.map((EpisodeDownload download) => download.getEpisodeFromDetails()).toList();
                            });
                          });
                        },
                      ),
                    ),
                  )).toList(),
                ),
                padding: const EdgeInsets.all(16.0),
              )
              : const PlaceholderScreen(
                icon: Icons.get_app,
                subtitle: 'Download episodes and manage them here.',
                title: 'No downloads yet',
              );
        },
      ),
      bottomNavigationBar: const BottomAppBarPlayer(),
    );
  }
}
