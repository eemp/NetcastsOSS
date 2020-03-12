// ignore_for_file: always_specify_types
import 'dart:async';

import 'package:hear2learn/app.dart';
import 'package:hear2learn/services/connectors/elastic.dart';
import 'package:hear2learn/models/podcast.dart';
import 'package:hear2learn/models/podcast_v2.dart' as pv2;
import 'package:hear2learn/models/podcast_subscription.dart';

const String PODCAST_TYPE = 'podcast';

Future<List<Podcast>> getSubscriptions() {
  final App app = App();
  final PodcastSubscriptionBean subscriptionModel = app.models['podcast_subscription'];

  return subscriptionModel.findWhere(subscriptionModel.isSubscribed.eq(true)).then((response) {
    return Future.wait(response.map((subscription) => Future.value(subscription.getPodcastFromDetails())));
  });
}

Future<List<Podcast>> searchPodcastsByGenre(String genreId) async {
  final App app = App();
  final pv2.MyDatabase podcastsDB = app.podcastsDB;
  final client = app.elasticClient;

  return podcastsDB.podcastsByGenre(genreId).then((podcasts) =>
    podcasts.map((podcast) =>
      // TODO: replace usage of legacy model
      Podcast(
        artwork30: podcast.artwork30,
        artwork60: podcast.artwork60,
        artwork100: podcast.artwork100,
        artwork600: podcast.artwork600,
        artworkOrig: podcast.artworkOrig,
        description: podcast.description,
        //List<Episode> episodes;
        episodesCount: podcast.episodesCount,
        feed: podcast.feed,
        //List<Genre> genres;
        id: podcast.id,
        //DateTime lastModifiedDate;
        logoUrl: podcast.logoUrl,
        name: podcast.name,
        //primaryGenre: podcast.primaryGenre,
        //popularity: podcast.popularity,
        title: podcast.title,
        //DateTime releaseDate;
        url: podcast.url,
      )
    ).toList()
  ).catchError((err, stack) {
    print('Ran into error: ' + err.toString());
    print(stack.toString());
    return err;
  });
}

Future<List<Podcast>> searchPodcastsByTextQuery(String textQuery, { int pageSize = 10, int page = 0 }) async {
  final App app = App();
  final client = app.elasticClient;

  final query = {
    'from': page * pageSize,
    'query': {
      'bool': {
        'filter': [
          { 'exists': { 'field': 'feed' } },
        ],
        'minimum_should_match': 1,
        'should': [
          {
            'multi_match': {
              'fields': [
                'name^16',
                'artist.name^8',
                'genre^8',
                'description',
              ],
              'operator': 'and',
              'query': textQuery
            }
          }
        ],
      }
    },
    'size': pageSize,
  };
  return client.search(
    body: query,
    type: PODCAST_TYPE,
  ).then((response) => toPodcasts(response));
}

Future<void> subscribeToPodcast(Podcast podcast) async {
  final App app = App();
  final PodcastSubscriptionBean subscriptionModel = app.models['podcast_subscription'];
  final PodcastSubscription newSubscription = PodcastSubscription(
    created: DateTime.now(),
    details: podcast.toJson(),
    isSubscribed: true,
    podcastId: podcast.id,
    podcastUrl: podcast.feed,
  );
  await subscriptionModel.insert(newSubscription);
}

Future<void> unsubscribeFromPodcast(Podcast podcast) async {
  final App app = App();
  final PodcastSubscriptionBean subscriptionModel = app.models['podcast_subscription'];
  await subscriptionModel.removeWhere(subscriptionModel.podcastUrl.eq(podcast.feed));
}

List<Podcast> toPodcasts(ElasticsearchResponse response) {
  return response.hits.map((hit) => Podcast.fromJson(hit.source)).toList();
}
