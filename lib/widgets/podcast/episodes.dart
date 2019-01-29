import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:hear2learn/redux/selectors.dart';
import 'package:hear2learn/redux/state.dart';
import 'package:hear2learn/widgets/common/episode_tile.dart';
import 'package:hear2learn/widgets/episode/index.dart';
import 'package:hear2learn/models/episode.dart';

class PodcastEpisodesList extends StatelessWidget {
  final Function onEpisodeDelete;
  final Function onEpisodeDownload;
  final List<Episode> episodes;

  const PodcastEpisodesList({
    Key key,
    this.onEpisodeDelete,
    this.onEpisodeDownload,
    this.episodes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        itemCount: episodes.length,
        itemBuilder: (BuildContext context, int idx) {
          final Episode episode = episodes[idx];

          return StoreConnector<AppState, Episode>(
            converter: getEpisodeSelector(episode),
            builder: episodeTileBuilder,
          );
        },
        separatorBuilder: (BuildContext context, int index) => Divider(),
        shrinkWrap: true,
      ),
    );
  }

  Widget episodeTileBuilder(BuildContext context, Episode episode) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(builder: (BuildContext context) => EpisodePage(episode: episode)),
        );
      },
      child: EpisodeTile(
        subtitle: episode.getMetaLine(),
        title: episode.title,
        options: episode.downloadPath != null
          ? buildDeleteOption(episode)
          : episode.progress != null
            ? buildDownloadProgress(episode)
            : buildDownloadOption(episode),
      ),
    );
  }

  Widget buildDeleteOption(Episode episode) {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () {
        onEpisodeDelete(episode);
      },
    );
  }

  Widget buildDownloadOption(Episode episode) {
    return IconButton(
      icon: const Icon(Icons.get_app),
      onPressed: () {
        onEpisodeDownload(episode);
      },
    );
  }

  Widget buildDownloadProgress(Episode episode) {
    return IconButton(
      icon: CircularProgressIndicator(value: episode.progress),
      onPressed: null,
    );
  }
}
