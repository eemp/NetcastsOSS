import 'package:hear2learn/models/podcast.dart';
import 'package:hear2learn/services/feeds/podcast.dart';
import 'package:test/test.dart';

void main() {
  test('Sample podcast feed request', () async {
    final Podcast value = await getPodcastFromFeed(url: 'http://feeds.feedburner.com/thetimferrissshow');
    expect(value.episodes.isNotEmpty, equals(true));
  });
}
