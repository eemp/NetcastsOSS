import 'package:swagger/api.dart';
import 'package:test/test.dart';

void main() {
  final PodcastApi api = PodcastApi();
  test('Gpodder API sample hit', () async {
    final List<Podcast> value = await api.searchPodcasts('Startalk');
    expect(value.isNotEmpty, equals(true));
  });
}
