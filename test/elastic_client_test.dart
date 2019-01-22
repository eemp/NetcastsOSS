import 'package:hear2learn/services/api/elastic.dart';
import 'package:hear2learn/services/feeds/podcast.dart';
import 'package:hear2learn/models/podcast.dart';
import 'package:test/test.dart';

main() {
  test("Sample elasticsearch request", () async {
    final client = ElasticsearchClient(
      host: 'qjrddhgpbq:41vtfspb70@podcasts-9232921312.us-east-1.bonsaisearch.net',
      index: 'hear2learn',
    );
    var res = await client.search(
      query: 'infinite monkey cage',
      type: 'podcast',
    );
    expect(res.hits[0].source['name'], equals('The Infinite Monkey Cage'));
  });
}

