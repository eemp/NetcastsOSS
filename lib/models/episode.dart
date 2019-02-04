import 'dart:convert';

import 'package:hear2learn/app.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

enum EpisodeStatus {
  DOWNLOADED,
  DOWNLOADING,
  NONE,
  PAUSED,
  PLAYING,
}

class Episode {
  final App app = App();

  String description;
  String downloadPath;
  Duration length;
  String media;
  String podcastTitle;
  String podcastUrl;
  Duration position;
  double progress;
  String pubDate;
  int size;
  EpisodeStatus status;
  String title;
  String url;

  Episode({
    this.description,
    this.downloadPath,
    this.length,
    this.media,
    this.podcastTitle,
    this.podcastUrl,
    this.position,
    this.progress,
    this.pubDate,
    this.size,
    this.status,
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
