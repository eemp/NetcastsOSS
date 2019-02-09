import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/redux/selectors.dart';
import 'package:hear2learn/redux/state.dart';
import 'package:hear2learn/widgets/common/episode_tile.dart';
import 'package:hear2learn/widgets/common/circular_progress_with_optional_action.dart';
import 'package:hear2learn/widgets/episode/index.dart';

class PodcastEpisodesList extends StatelessWidget {
  final Function onEpisodeDelete;
  final Function onEpisodeDownload;
  final Function onEpisodePause;
  final Function onEpisodePlay;
  final Function onEpisodeResume;
  final List<Episode> episodes;

  const PodcastEpisodesList({
    Key key,
    this.onEpisodeDelete,
    this.onEpisodeDownload,
    this.onEpisodePause,
    this.onEpisodePlay,
    this.onEpisodeResume,
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
        separatorBuilder: (BuildContext context, int index) => const Divider(),
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
        emphasis: !episode.isPlayedToEnd(),
        subtitle: episode.getMetaLine(),
        title: episode.title,
        options: buildEpisodeOptions(episode),
      ),
    );
  }

  Widget buildEpisodeOptions(Episode episode) {
    return CircularProgressWithOptionalAction(
      icon: getEpisodeIcon(episode),
      onPressed: getEpisodeAction(episode),
      progress: getEpisodeProgress(episode),
    );
  }

  Icon getEpisodeIcon(Episode episode) {
    const Map<EpisodeStatus, Icon> icons = <EpisodeStatus, Icon>{
      EpisodeStatus.DOWNLOADED: Icon(Icons.play_arrow),
      EpisodeStatus.DOWNLOADING: Icon(Icons.more_horiz),
      EpisodeStatus.NONE: Icon(Icons.get_app),
      EpisodeStatus.PAUSED: Icon(Icons.play_arrow),
      EpisodeStatus.PLAYING: Icon(Icons.pause),
      EpisodeStatus.PLAYED: Icon(Icons.delete),
    };
    return icons[episode.status];
  }

  Function getEpisodeAction(Episode episode) {
    final Map<EpisodeStatus, Function> actions = <EpisodeStatus, Function>{
      EpisodeStatus.DOWNLOADED: () { onEpisodePlay(episode); },
      EpisodeStatus.DOWNLOADING: null,
      EpisodeStatus.NONE: () { onEpisodeDownload(episode); },
      EpisodeStatus.PAUSED: onEpisodeResume,
      EpisodeStatus.PLAYING: () { onEpisodePause(episode); },
      EpisodeStatus.PLAYED: () { onEpisodeDelete(episode); },
    };
    return actions[episode.status];
  }

  double getEpisodeProgress(Episode episode) {
    if(episode.status == EpisodeStatus.PLAYED || episode.status == EpisodeStatus.NONE) {
      return null;
    }
    if(episode.status == EpisodeStatus.DOWNLOADING) {
      return episode.progress;
    }
    if((episode.position?.inSeconds ?? 0) > 0) {
      return (episode.position?.inSeconds?.toDouble() ?? 0)
        / (episode.length?.inSeconds?.toDouble() ?? 1);
    }
    return null;
  }
}
