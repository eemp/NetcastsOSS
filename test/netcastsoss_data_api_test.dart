import 'package:netcastsoss_data_api/api.dart';
import 'package:netcastsoss_data_api/model/podcasts_filter.dart';
import 'package:test/test.dart';


void main() {
  final jaguarApiGen = NetcastsossDataApi();

  test('Ping NetcastsOSS Data API', () async {
    var api_instance = jaguarApiGen.getPingControllerApi();
    var result = await api_instance.pingControllerPing();
    expect(result.greeting, equals('Hello from LoopBack'));
    expect(result.url, equals('/ping'));
  });

  test('Fetch top podcasts by genre', () async {
    var api_instance = jaguarApiGen.getPodcastsControllerApi();
    var result = await api_instance.podcastsControllerFindPopularPodcasts(null);
    expect(result.length, equals(10));
    expect(result[0].genre, equals('Comedy'));
    expect(result[0].items[0].name, equals('The Joe Rogan Experience'));
    expect(result[1].genre, equals('Personal Journals'));
    expect(result[1].items[0].name, equals('This American Life'));
  });

  test('Search podcasts by keywords', () async {
    var api_instance = jaguarApiGen.getPodcastsControllerApi();
    var result = await api_instance.podcastsControllerSearchPodcastsByText('Infinite Monkey Cage', PodcastsFilter(
      limit: 1,
    ));
    expect(result.length, equals(1));
    expect(result[0].name, equals('The Infinite Monkey Cage'));
  });
}

