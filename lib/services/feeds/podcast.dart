import 'package:flutter/foundation.dart';

import 'package:hear2learn/services/feeds/podcast.dart';
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/models/podcast.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

Future<Podcast> getPodcastFromFeed(String url) async {
  final response = await http.get(url);
  RssFeed feed = await compute(parseFeed, response.body);

  List<Episode> episodes = feed.items.map((item) => new Episode(
    description: item.description,
    podcastTitle: feed.title,
    podcastUrl: url,
    pubDate: item.pubDate,
    size: item.enclosure?.length,
    title: item.title,
    url: item.enclosure.url,
  )).toList();

  return Podcast(
    description: feed.description,
    episodes: episodes,
    logoUrl: feed.image?.url,
    title: feed.title,
    url: url,
  );
}

RssFeed parseFeed(String responseBody) {
  return RssFeed.parse(responseBody);
}
