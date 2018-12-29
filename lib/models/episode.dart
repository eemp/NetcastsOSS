import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class Episode {
  String description;
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
    num sizeInMegabytes = size / 10e6;
    return 'Size: ' + sizeInMegabytes.toStringAsFixed(2) + ' MB.  Added: ' + this.getFriendlyDate() + '.';
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
