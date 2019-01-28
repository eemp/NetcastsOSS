import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hear2learn/app.dart';
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/models/episode_download.dart';
import 'package:path/path.dart';

final Dio dio = Dio();

Future<void> downloadEpisode(Episode episode, {OnDownloadProgress onProgress}) async {
  final App app = App();
  final EpisodeDownloadBean downloadModel = app.models['episode_download'];
  final String downloadId = EpisodeDownload.createNewId();
  final String downloadPath = join(await app.getApplicationDownloadsPath(), '$downloadId.mp3');
  final EpisodeDownload download = EpisodeDownload(
    created: DateTime.now(),
    details: episode.toJson(),
    downloadPath: downloadPath,
    episodeUrl: episode.url,
    id: downloadId,
  );
  await dio.download(episode.url, download.downloadPath, onProgress: onProgress);
  await downloadModel.insert(download);
  episode.download = download;
}

Future<void> deleteEpisode(Episode episode) async {
  final App app = App();
  final EpisodeDownloadBean downloadModel = app.models['episode_download'];
  final EpisodeDownload episodeDownload = await downloadModel.findOneWhere(downloadModel.episodeUrl.eq(episode.url));
  await File(episodeDownload.downloadPath).delete();
  await downloadModel.removeWhere(downloadModel.episodeUrl.eq(episode.url));
  episode.download = null;
}
