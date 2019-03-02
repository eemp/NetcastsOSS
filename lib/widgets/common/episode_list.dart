import 'package:flutter/material.dart';

import 'package:hear2learn/app.dart';
import 'package:hear2learn/helpers/dash.dart' as dash;
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/redux/actions.dart';
import 'package:hear2learn/widgets/common/episode_tile_connector.dart';

class EpisodesList extends StatefulWidget {
  final List<Episode> episodes;

  const EpisodesList({
    Key key,
    this.episodes,
  }) : super(key: key);

  @override
  EpisodesListState createState() => EpisodesListState();
}

class EpisodesListState extends State<EpisodesList> {
  List<Episode> get episodes => widget.episodes;

  ActionType selectedAction;
  Map<Episode, bool> selectedEpisodes;

  @override
  void initState() {
    super.initState();
    // ignore: prefer_collection_literals
    selectedEpisodes = Map<Episode, bool>();
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
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          selectedAction == ActionType.DELETE_EPISODE
                            ? Icons.delete
                            : Icons.get_app
                        ),
                        onPressed: () {
                          if(selectedAction == ActionType.DOWNLOAD_EPISODE) {
                            onBatchDownload(getSelectedEpisodes(), context: context);
                          }
                          else if(selectedAction == ActionType.DELETE_EPISODE) {
                            onBatchDelete(getSelectedEpisodes());
                          }
                          clearSelections();
                        },
                      ),
                    ],
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

  void toggleEpisodeSelection(Episode episode) {
    setState(() {
      if(isAvailableForBatchAction(episode)) {
        selectedEpisodes.update(episode, (bool value) => !value, ifAbsent: () => true);
        selectedAction = !inSelectMode()
          ? null
          : dash.isNotEmpty(episode.downloadPath)
            ? ActionType.DELETE_EPISODE
            : ActionType.DOWNLOAD_EPISODE
          ;
      }
    });
  }

  bool isAvailableForBatchAction(Episode episode) {
    if(episode.status == EpisodeStatus.DOWNLOADING) {
      return false;
    }

    if(selectedAction == ActionType.DOWNLOAD_EPISODE) {
      return dash.isEmpty(episode.downloadPath);
    }
    if(selectedAction == ActionType.DELETE_EPISODE) {
      return dash.isNotEmpty(episode.downloadPath);
    }
    // else no selection made yet
    return true;
  }

  bool inSelectMode() {
    return dash.find(selectedEpisodes.values.toList(), (bool val) => val) ?? false;
  }

  List<Episode> getSelectedEpisodes() {
    return selectedEpisodes.keys.where((Episode episode) => selectedEpisodes[episode]).toList();
  }

  void clearSelections() {
    setState(() {
      selectedAction = null;
      selectedEpisodes.clear();
    });
  }

  void onBatchDownload(List<Episode> episodes, { BuildContext context }) {
    final App app = App();
    app.store.dispatch(batchDownload(episodes, context: context));
  }

  void onBatchDelete(List<Episode> episodes) {
    final App app = App();
    app.store.dispatch(batchDelete(episodes));
  }
}
