import 'package:flutter/material.dart';

import 'package:hear2learn/app.dart';
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/redux/actions.dart';
import 'package:hear2learn/widgets/episode/info.dart';
import 'package:hear2learn/widgets/episode/home.dart';
import 'package:share/share.dart';

class EpisodePage extends StatelessWidget {
  static const String routeName = 'EpisodePage';

  final Episode episode;

  const EpisodePage({
    Key key,
    this.episode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Episode of ' + episode.podcastTitle),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.music_video),
                text: 'Episode',
              ),
              Tab(
                icon: Icon(Icons.info),
                text: 'Info',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Container(
              child: EpisodeHome(
                episode: episode,
                onDelete: deleteHandler(context),
                onDownload: downloadHandler(context),
                onFavorite: onFavorite,
                onFinish: onFinish,
                onPause: onPause,
                onPlay: onPlay,
                onResume: onResume,
                onShare: onShare,
                onUnfavorite: onUnfavorite,
                onUnfinish: onUnfinish,
              ),
            ),
            Container(
              child: EpisodeInfo(
                episode: episode,
              ),
              margin: const EdgeInsets.all(16.0),
            ),
          ],
        ),
      ),
      length: 2,
    );
  }

  Function downloadHandler(BuildContext context) {
    final App app = App();

    return () {
      app.store.dispatch(downloadEpisode(episode, context: context));
    };
  }

  Function deleteHandler(BuildContext context) {
    final App app = App();

    return () {
      app.store.dispatch(deleteEpisode(episode, context: context));
    };
  }

  void onFavorite() {
    final App app = App();
    app.store.dispatch(favoriteEpisode(episode));
  }

  void onFinish() {
    final App app = App();
    app.store.dispatch(finishEpisode(episode));
  }

  void onPause() {
    final App app = App();
    app.store.dispatch(pauseEpisode(episode));
  }

  void onPlay() {
    final App app = App();
    app.store.dispatch(playEpisode(episode));
  }

  void onResume() {
    final App app = App();
    app.store.dispatch(resumeEpisode());
  }

  void onShare() {
    Share.share('Check out ${episode.title}, an episode of the ${episode.podcastTitle} podcast');
  }

  void onUnfavorite() {
    final App app = App();
    app.store.dispatch(unfavoriteEpisode(episode));
  }

  void onUnfinish() {
    final App app = App();
    app.store.dispatch(unfinishEpisode(episode));
  }
}
