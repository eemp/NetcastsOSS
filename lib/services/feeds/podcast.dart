import 'package:hear2learn/services/feeds/podcast.dart';
import 'package:hear2learn/models/episode.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

Future<List<Episode>> getPodcastEpisodes(String url) async {
  var response = await http.get(url);
  var feed = new RssFeed.parse(response.body);
  return feed.items.map((item) => new Episode(
    description: item.description,
    podcastTitle: feed.title,
    podcastUrl: url,
    pubDate: item.pubDate,
    size: item.enclosure?.length,
    title: item.title,
    url: item.enclosure.url,
  )).toList();
}
