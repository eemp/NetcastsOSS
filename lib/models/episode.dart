import 'dart:async';
import 'dart:convert';

import 'package:hear2learn/app.dart';
import 'package:hear2learn/models/episode_download.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class Episode {
  final App app = App();

  String description;
  EpisodeDownload download;
  String downloadPath;
  String media;
  String podcastTitle;
  String podcastUrl;
  double progress;
  String pubDate;
  int size;
  String title;
  String url;

  Episode({
    this.description,
    this.download,
    this.downloadPath,
    this.media,
    this.podcastTitle,
    this.podcastUrl,
    this.progress,
    this.pubDate,
    this.size,
    this.title,
    this.url,
  });

  String getFriendlyDate() {
    const String shortFormat = 'EEE, dd MMM yyyy';
    final DateFormat podcastDateFormat = DateFormat(shortFormat);
    return timeago.format(podcastDateFormat.parseLoose(pubDate.substring(0, shortFormat.length)));
  }

  String getMetaLine() {
    final num sizeInMegabytes = size / 1e6;
    return 'Size: ' + sizeInMegabytes.toStringAsFixed(2) + ' MB.  Added: ' + getFriendlyDate() + '.';
  }

  Future<EpisodeDownload> getDownload() async {
    final EpisodeDownloadBean downloadModel = app.models['episode_download'];
    download = await downloadModel.findOneWhere(downloadModel.episodeUrl.eq(url));
    return download;
  }

  @override
  String toString() {
    return 'Episode[description=$description, media=$media, pubDate=$pubDate, size=$size, title=$title, url=$url, ]';
  }

  String toJson() {
    return jsonEncode(<String, dynamic>{
      'description': description,
      'media': media,
      'podcastTitle': podcastTitle,
      'podcastUrl': podcastUrl,
      'pubDate': pubDate,
      'size': size,
      'title': title,
      'url': url,
    });
  }
}
