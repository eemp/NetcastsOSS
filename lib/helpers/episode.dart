import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hear2learn/app.dart';
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/models/episode_action.dart';
import 'package:hear2learn/models/user_episode.dart';
import 'package:path/path.dart';

final Dio dio = Dio();

Future<List<Episode>> getDownloads() {
  final App app = App();
  final EpisodeActionBean episodeActionModel = app.models['episode_action'];

  return episodeActionModel.findWhere(
    episodeActionModel.type.eq(EpisodeActionType.DOWNLOAD.toString())
  ).then((List<EpisodeAction> response) {
    return Future.wait(
      response.map(
        (EpisodeAction download) => Future<Episode>.value(getUserEpisodeFromUrl(download.url)).then((Episode episode) {
          episode.downloadPath = download.details;
          return episode;
        })
      )
    );
  }).then((List<Episode> downloadsList) => List<Episode>.from(downloadsList));
}

Future<Episode> getUserEpisodeFromUrl(String url) async {
  final App app = App();
  final UserEpisodeBean userEpisodeModel = app.models['user_episode'];
  final UserEpisode userEpisode = await userEpisodeModel.findOneWhere(
    userEpisodeModel.url.eq(url)
  );
  return userEpisode?.getEpisodeFromDetails();
}

Future<void> downloadEpisode(Episode episode, {OnDownloadProgress onProgress}) async {
  final App app = App();
  final EpisodeActionBean episodeActionModel = app.models['episode_action'];
  final UserEpisodeBean userEpisodeModel = app.models['user_episode'];

  final String downloadId = EpisodeAction.createNewId();
  final String downloadPath = join(await app.getApplicationDownloadsPath(), '$downloadId.mp3');
  final EpisodeAction download = EpisodeAction(
    actionType: EpisodeActionType.DOWNLOAD,
    details: downloadPath,
    id: downloadId,
    url: episode.url,
  );

  await dio.download(episode.url, downloadPath, onProgress: onProgress);

  await episodeActionModel.insert(download);
  await userEpisodeModel.insert(
    UserEpisode(
      details: episode.toJson(),
      url: episode.url,
    )
  );

  episode.downloadPath = downloadPath;
  episode.progress = null;
}

Future<void> deleteEpisode(Episode episode) async {
  final App app = App();
  final EpisodeActionBean episodeActionModel = app.models['episode_action'];
  final EpisodeAction download = await episodeActionModel.findOneWhere(episodeActionModel.url.eq(episode.url));
  await File(download.details).delete();
  await episodeActionModel.removeWhere(
    episodeActionModel.url.eq(episode.url)
      .and(episodeActionModel.type.eq(EpisodeActionType.DOWNLOAD.toString()))
  );
  episode.downloadPath = null;
}
