import 'package:hear2learn/services/api/itunes_search.dart';
import 'package:test/test.dart';

main() {
  test("Search itunes for podcasts", () async {
    ITunesSearchAPI api = new ITunesSearchAPI();
    List<ITunesSearchAPIResult> results = await api.search('ted talks');
    expect(results.length > 0, equals(true));
    expect(results[0].collectionName, matches(RegExp(r'ted', caseSensitive: false)));
    print('Fetched ${results.length} total results from iTunes Search API.');
  });
}
