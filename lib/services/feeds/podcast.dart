import 'dart:async';
import 'dart:io';
//import 'package:flutter/foundation.dart';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hear2learn/helpers/dash.dart' as dash;
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/models/podcast.dart';
import 'package:webfeed/webfeed.dart';

Future<Podcast> getPodcastFromFeed({
  Podcast podcast,
  String url,
  BaseCacheManager cacheManager
}) async {
  //final response = await http.get(url);
  //RssFeed feed = await dash.compute(parseFeed, response.body);
  url = podcast?.feed ?? url;

  //CacheManager.showDebugLogs = true;
  final File file = await (cacheManager ?? DefaultCacheManager()).getSingleFile(url);
  final String feedContent = await file.readAsString();
  final RssFeed feed = await dash.compute(parseFeed, feedContent);

  final List<Episode> episodes = feed.items.map((RssItem item) => Episode(
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
