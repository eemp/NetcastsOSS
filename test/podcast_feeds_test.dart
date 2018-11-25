import 'package:hear2learn/services/feeds/podcast.dart';
import 'package:test/test.dart';

main() {
  test("Sample podcast feed request", () async {
    var value = await getPodcastEpisodes('http://feeds.feedburner.com/thetimferrissshow');
    expect(value is List, equals(true));
    expect(value.length > 0, equals(true));
  });
}
