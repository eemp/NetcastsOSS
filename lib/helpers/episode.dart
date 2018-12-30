import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hear2learn/app.dart';
import 'package:hear2learn/models/episode_download.dart';
import 'package:path/path.dart';

final Dio dio = new Dio();

void downloadEpisode(episodeUrl, details) async {
  App app = App();
  EpisodeDownloadBean downloadModel = app.models['episode_download'];
  String downloadId = EpisodeDownload.createNewId();
  String downloadPath = join(await app.getApplicationDownloadsPath(), '${downloadId}.mp3');
  EpisodeDownload download = new EpisodeDownload(
    created: DateTime.now(),
    details: details,
    downloadPath: downloadPath,
    episodeUrl: episodeUrl,
    id: downloadId,
  );
  await dio.download(episodeUrl, download.downloadPath);
  await downloadModel.insert(download);
}

void deleteEpisode(episodeUrl) async {
  App app = App();
  EpisodeDownloadBean downloadModel = app.models['episode_download'];
  await downloadModel.findOneWhere(downloadModel.episodeUrl.eq(episodeUrl)).then((episodeDownload) {
    return Future.wait([
      File(episodeDownload.downloadPath).delete(),
      downloadModel.removeWhere(downloadModel.episodeUrl.eq(episodeUrl)),
    ]);
  });
}
