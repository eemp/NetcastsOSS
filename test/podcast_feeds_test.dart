import 'dart:core';
import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_cache_manager/src/cache_store.dart';
import 'package:flutter_cache_manager/src/web/web_helper.dart';
import 'package:hear2learn/models/podcast.dart';
import 'package:hear2learn/services/feeds/podcast.dart';
import 'package:mockito/mockito.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

void main() {
  test('Sample podcast feed request', () async {
    const url = 'https://podcasts.files.bbci.co.uk/b00snr0w.rss';
    TestCacheManager testCacheManager = TestCacheManager();
    final Podcast podcast = await getPodcastFromFeed(
      url: url,
      cacheManager: testCacheManager
    );
    expect(podcast.name, equals('The Infinite Monkey Cage'));
    expect(podcast.episodes.isNotEmpty, equals(true));
  });
}

class TestCacheManager extends BaseCacheManager {
  TestCacheManager() : super('test',
    cacheStore: MockCacheStore(),
    webHelper: MockWebHelper(),
  );

  @override
  Future<File> getSingleFile(String url, {Map<String, String> headers}) {
    String samplePath = path.join(path.dirname(Platform.script.path), 'sample_feed.rss');
    return Future.value(File(samplePath));
  }

  @override
  Future<String> getFilePath() {
    //Not needed because we supply our own store
    throw UnimplementedError();
  }
}

class MockCacheStore extends Mock implements CacheStore {}
class MockWebHelper extends Mock implements WebHelper {}
