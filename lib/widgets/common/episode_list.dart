import 'package:flutter/material.dart';

import 'package:hear2learn/app.dart';
import 'package:hear2learn/helpers/dash.dart' as dash;
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/redux/actions.dart';
import 'package:hear2learn/widgets/common/episode_tile_connector.dart';

class EpisodesList extends StatefulWidget {
  final List<Episode> episodes;
  final EpisodeQueue episodeQueue;

  const EpisodesList({
    Key key,
    this.episodes,
    this.episodeQueue,
  }) : super(key: key);

  @override
  EpisodesListState createState() => EpisodesListState();
}

class EpisodesListState extends State<EpisodesList> {
  List<Episode> get episodes => widget.episodes;
  EpisodeQueue get episodeQueue => widget.episodeQueue;

  List<ActionType> availableActions = <ActionType>[
    ActionType.DOWNLOAD_EPISODE,
    ActionType.DELETE_EPISODE,
    ActionType.FAVORITE_EPISODE,
    ActionType.FINISH_EPISODE,
    ActionType.UNFAVORITE_EPISODE,
    ActionType.UNFINISH_EPISODE,
  ];

  Map<Episode, bool> selectedEpisodes;
  List<ActionType> visibleActions;

  @override
  void initState() {
    super.initState();
    // ignore: prefer_collection_literals
    selectedEpisodes = Map<Episode, bool>();
    visibleActions = <ActionType>[];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        itemCount: episodes.length + 1,
        itemBuilder: (BuildContext context, int idx) {
          if(idx == 0) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: inSelectMode() ? Row(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: clearSelections,
                  ),
                  const Text('Finish selecting episodes'),
                  Row(
                    children: visibleActions.map(
                      (ActionType action) {
                        Icon icon;
                        switch (action) {
                          case ActionType.DELETE_EPISODE:
                            icon = const Icon(Icons.delete);
                            break;
                          case ActionType.DOWNLOAD_EPISODE:
                            icon = const Icon(Icons.get_app);
                            break;
                          case ActionType.FAVORITE_EPISODE:
                            icon = const Icon(Icons.favorite);
                            break;
                          case ActionType.FINISH_EPISODE:
                            icon = const Icon(Icons.done);
                            break;
                          case ActionType.UNFAVORITE_EPISODE:
                            icon = const Icon(Icons.favorite_border);
                            break;
                          case ActionType.UNFINISH_EPISODE:
                            icon = const Icon(Icons.done_outline);
                            break;
                          default:
                            icon = const Icon(Icons.broken_image);
                            break;
                        }
                        return IconButton(
                          icon: icon,
                          onPressed: () {
                            switch (action) {
                              case ActionType.DELETE_EPISODE:
                                onBatchDelete(getSelectedEpisodes(), context: context);
                                break;
                              case ActionType.DOWNLOAD_EPISODE:
                                onBatchDownload(getSelectedEpisodes(), context: context);
                                break;
                              case ActionType.FAVORITE_EPISODE:
                                onBatchFavorite(getSelectedEpisodes());
                                break;
                              case ActionType.FINISH_EPISODE:
                                onBatchFinish(getSelectedEpisodes());
                                break;
                              case ActionType.UNFAVORITE_EPISODE:
                                onBatchUnfavorite(getSelectedEpisodes());
                                break;
                              case ActionType.UNFINISH_EPISODE:
                                onBatchUnfinish(getSelectedEpisodes());
                                break;
                              default:
                                break;
                            }
                            clearSelections();
                          },
                        );
                      }
                    ).toList(),
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ) : Row(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.info_outline),
                    onPressed: null,
                  ),
                  const Text('Press and hold items below to select'),
                ],
              ),
            );
          }

          final Episode episode = episodes[idx - 1];
          return EpisodeTileConnector(
            episode: episode,
            episodeQueue: episodeQueue,
            isSelected: selectedEpisodes[episode] ?? false,
            selectOnTap: inSelectMode(),
            toggleEpisodeSelection: toggleEpisodeSelection,
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(height: 1.0),
        shrinkWrap: true,
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
    );
  }

  bool canDeleteEpisode(Episode episode) {
    return !canDownloadEpisode(episode);
  }

  bool canDownloadEpisode(Episode episode) {
    return dash.isEmpty(episode.downloadPath);
  }

  bool canFinishEpisode(Episode episode) {
    return !episode.isFinished;
  }

  bool canUnfinishEpisode(Episode episode) {
    return episode.isFinished;
  }

  void clearSelections() {
    setState(() {
      selectedEpisodes.clear();
    });
  }

  List<Episode> getSelectedEpisodes({ Map<Episode, bool> episodes }) {
    final Map<Episode, bool> episodesToUse = episodes == null ? selectedEpisodes : episodes;
    return episodesToUse.keys.where((Episode episode) => selectedEpisodes[episode]).toList();
  }

  bool isAvailableForBatchAction(Episode episode) {
    // Episode can be selected if no other episodes are selected, or if one of the available actions remaining can be applied to it
    if (getSelectedEpisodes().isEmpty) {
      return true;
    }
    return visibleActions.where((ActionType action) {
      switch (action) {
        case ActionType.DELETE_EPISODE:
          return canDeleteEpisode(episode);
        case ActionType.DOWNLOAD_EPISODE:
          return canDownloadEpisode(episode);
        case ActionType.FINISH_EPISODE:
          return canFinishEpisode(episode);
        case ActionType.UNFINISH_EPISODE:
          return canUnfinishEpisode(episode);
        default:
          return false;
      }
    }).isNotEmpty;
  }

  bool inSelectMode() {
    return dash.find(selectedEpisodes.values.toList(), (bool val) => val) ?? false;
  }

  void onBatchDelete(List<Episode> episodes, { BuildContext context }) {
    final App app = App();
    app.store.dispatch(batchDelete(episodes, context: context));
  }

  void onBatchDownload(List<Episode> episodes, { BuildContext context }) {
    final App app = App();
    app.store.dispatch(batchDownload(episodes, context: context));
  }

  void onBatchFavorite(List<Episode> episodes) {
    final App app = App();
    app.store.dispatch(batchFavorite(episodes));
  }

  void onBatchFinish(List<Episode> episodes, { BuildContext context }) {
    final App app = App();
    app.store.dispatch(batchFinish(episodes));
  }

  void onBatchUnfavorite(List<Episode> episodes) {
    final App app = App();
    app.store.dispatch(batchUnfavorite(episodes));
  }

  void onBatchUnfinish(List<Episode> episodes, { BuildContext context }) {
    final App app = App();
    app.store.dispatch(batchUnfinish(episodes));
  }

  void toggleEpisodeSelection(Episode episode) {
    setState(() {
      if(isAvailableForBatchAction(episode)) {
        selectedEpisodes.update(episode, (bool value) => !value, ifAbsent: () => true);
        final List<Episode> episodes = getSelectedEpisodes(episodes: selectedEpisodes);
        visibleActions = availableActions.where(
          (ActionType action) {
            switch (action) {
              case ActionType.DELETE_EPISODE:
                return episodes.where(canDownloadEpisode).toList().isEmpty;
              case ActionType.DOWNLOAD_EPISODE:
                return episodes.where(canDeleteEpisode).toList().isEmpty;
              case ActionType.FINISH_EPISODE:
                return episodes.where(canUnfinishEpisode).toList().isEmpty;
              case ActionType.UNFINISH_EPISODE:
                return episodes.where(canFinishEpisode).toList().isEmpty;
              default:
                return false;
            }
          }
        ).toList();
      }
    });
  }
}
