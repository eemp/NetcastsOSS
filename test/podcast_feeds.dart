import 'package:hear2learn/services/feeds/podcast.dart';
import 'package:test/test.dart';

main() {
  test("Fetched episodes via podcast feed url", () async {
    var value = await getPodcastEpisodes('http://feeds.feedburner.com/thetimferrissshow');
    expect(value is List, equals(true));
  });
}

