import 'package:swagger/api.dart';
import 'package:test/test.dart';

main() {
  var podcast_api_instance = new PodcastApi();
  test("Gpodder API sample hit", () async {
    var value = await podcast_api_instance.searchPodcasts('Startalk');
    expect(value is List, equals(true));
    expect(value.length > 0, equals(true));
  });
}
