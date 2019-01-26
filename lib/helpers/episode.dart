import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hear2learn/app.dart';
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/models/episode_download.dart';
import 'package:path/path.dart';

final Dio dio = new Dio();

Future<void> downloadEpisode(episode) async {
  App app = App();
  EpisodeDownloadBean downloadModel = app.models['episode_download'];
  String downloadId = EpisodeDownload.createNewId();
  String downloadPath = join(await app.getApplicationDownloadsPath(), '${downloadId}.mp3');
  EpisodeDownload download = new EpisodeDownload(
    created: DateTime.now(),
    details: episode.toJson(),
    downloadPath: downloadPath,
    episodeUrl: episode.url,
    id: downloadId,
  );
  await dio.download(episode.url, download.downloadPath);
  await downloadModel.insert(download);
  episode.download = download;
}

Future<void> deleteEpisode(episode) async {
  App app = App();
  EpisodeDownloadBean downloadModel = app.models['episode_download'];
  await downloadModel.findOneWhere(downloadModel.episodeUrl.eq(episode.url)).then((episodeDownload) {
    return Future.wait([
      File(episodeDownload.downloadPath).delete(),
      downloadModel.removeWhere(downloadModel.episodeUrl.eq(episode.url)),
    ]);
  });
  episode.download = null;
}
