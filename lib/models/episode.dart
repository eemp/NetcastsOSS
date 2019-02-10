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
  PLAYED,
  DELETED,
}

class Episode {
  final App app = App();

  static const int END_OF_EPISODE_THRESHOLD = 30;

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
    this.status = EpisodeStatus.NONE,
    this.title,
    this.url,
  });

  Episode copyWith({
    String description,
    String downloadPath,
    Duration length,
    String media,
    String podcastTitle,
    String podcastUrl,
    Duration position,
    double progress,
    String pubDate,
    int size,
    EpisodeStatus status,
    String title,
    String url,
  }) {
    return Episode(
      description: description ?? this.description,
      downloadPath: downloadPath ?? this.downloadPath,
      length: length ?? this.length,
      media: media ?? this.media,
      podcastTitle: podcastTitle ?? this.podcastTitle,
      podcastUrl: podcastUrl ?? this.podcastUrl,
      position: position ?? this.position,
      progress: progress ?? this.progress,
      pubDate: pubDate ?? this.pubDate,
      size: size ?? this.size,
      status: status ?? this.status,
      title: title ?? this.title,
      url: url ?? this.url,
    );
  }

  String getFriendlyDate() {
    const String shortFormat = 'EEE, dd MMM yyyy';
    final DateFormat podcastDateFormat = DateFormat(shortFormat);
    return timeago.format(podcastDateFormat.parseLoose(pubDate.substring(0, shortFormat.length)));
  }

  String getMetaLine() {
    final num sizeInMegabytes = size / 1e6;
    return 'Size: ' + sizeInMegabytes.toStringAsFixed(2) + ' MB.  Added: ' + getFriendlyDate() + '.';
  }

  String getPlayerDetails() {
    return jsonEncode(<int>[position.inSeconds, length.inSeconds]);
  }

  void setPlayerDetails(String details) {
    final List<dynamic> playerDetails = jsonDecode(details);
    length = Duration(seconds: playerDetails[1]);
    position = Duration(seconds: playerDetails[0]);
  }

  bool isPlaying() {
    return status == EpisodeStatus.PLAYING;
  }

  bool isPlayedToEnd() {
    if(length == null || position == null) {
      return false;
    }
    final Duration remainder = length - position;
    return remainder.inSeconds < END_OF_EPISODE_THRESHOLD;
  }

  @override
  String toString() {
    return 'Episode[title=$title, pubDate=$pubDate, status=${status.toString()}, size=$size, url=$url, ]';
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
