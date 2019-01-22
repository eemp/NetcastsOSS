import 'package:flutter/foundation.dart';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hear2learn/services/feeds/podcast.dart';
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/models/podcast.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

Future<Podcast> getPodcastFromFeed({ Podcast podcast, String url }) async {
  //final response = await http.get(url);
  //RssFeed feed = await compute(parseFeed, response.body);
  url = podcast?.feed ?? url;

  CacheManager.showDebugLogs = true;
  final cacheManager = await CacheManager.getInstance();
  var file = await cacheManager.getFile(url);
  String feedContent = await file.readAsString();
  RssFeed feed = await compute(parseFeed, feedContent);


  List<Episode> episodes = feed.items.map((item) => new Episode(
    description: item.description,
    podcastTitle: feed.title,
    podcastUrl: url,
    pubDate: item.pubDate,
    size: item.enclosure?.length,
    title: item.title,
    url: item.enclosure?.url,
  )).toList();

  if(podcast != null) {
    podcast.episodes = episodes;
  }

  return podcast ?? Podcast(
    artworkOrig: feed.image?.url,
    description: feed.description,
    episodes: episodes,
    feed: url,
    name: feed.title,
  );
}

RssFeed parseFeed(String responseBody) {
  return RssFeed.parse(responseBody);
}
