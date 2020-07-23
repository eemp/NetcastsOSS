import 'package:netcastsoss_data_api/api.dart';
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
    expect(result[0].items[0].popularity, equals(0));
  });

  test('Search podcasts by keywords', () async {
    var api_instance = jaguarApiGen.getPodcastsControllerApi();
    var result = await api_instance.podcastsControllerSearchPodcastsByText('Infinite Monkey Cage', 1);
    expect(result.length, equals(1));
    expect(result[0].name, equals('The Infinite Monkey Cage'));
  });
}

