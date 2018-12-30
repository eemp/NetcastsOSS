import 'dart:convert';

import 'package:hear2learn/app.dart';
import 'package:hear2learn/models/episode_download.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class Episode {
  final App app = App();

  String description;
  EpisodeDownload download;
  String media;
  String podcastTitle;
  String podcastUrl;
  String pubDate;
  int size;
  String title;
  String url;

  Episode({
    this.description,
    this.media,
    this.podcastTitle,
    this.podcastUrl,
    this.pubDate,
    this.size,
    this.title,
    this.url,
  });

  String getFriendlyDate() {
    String shortFormat = 'EEE, dd MMM yyyy';
    DateFormat podcastDateFormat = DateFormat(shortFormat);
    return timeago.format(podcastDateFormat.parseLoose(pubDate.substring(0, shortFormat.length)));
  }

  String getMetaLine() {
    num sizeInMegabytes = size / 1e6;
    return 'Size: ' + sizeInMegabytes.toStringAsFixed(2) + ' MB.  Added: ' + this.getFriendlyDate() + '.';
  }

  Future<EpisodeDownload> getDownload() async {
    EpisodeDownloadBean downloadModel = app.models['episode_download'];
    return downloadModel.findOneWhere(downloadModel.episodeUrl.eq(url))
      .then((episodeDownload) {
        download = episodeDownload;
        return Future.value(episodeDownload);
      });
  }

  @override
  String toString() {
    return 'Episode[description=$description, media=$media, pubDate=$pubDate, size=$size, title=$title, url=$url, ]';
  }

  String toJson() {
    return jsonEncode({
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
