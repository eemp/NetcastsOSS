import 'dart:io';

import 'package:hear2learn/app.dart';
import 'package:hear2learn/services/api/elastic.dart';
import 'package:hear2learn/models/podcast.dart';
import 'package:hear2learn/models/podcast_subscription.dart';

final String PODCAST_TYPE = 'podcast';

Future<List<Podcast>> getSubscriptions() {
  final App app = App();
  final PodcastSubscriptionBean subscriptionModel = app.models['podcast_subscription'];

  return subscriptionModel.findWhere(subscriptionModel.isSubscribed.eq(true)).then((response) {
    return Future.wait(response.map((subscription) => Future.value(subscription.getPodcastFromDetails())));
  });
}

Future<List<Podcast>> searchPodcastsByGenre(genreId) async {
  final App app = App();
  final client = app.elasticClient;

  var query = {
    'query': {
      'bool': {
        'filter': [
          { 'exists': { 'field': 'feed' } },
          {
            'term': {
              'genres.id': genreId,
            }
          }
        ]
      }
    },
    'sort': [
      'popularity',
    ],
  };
  return client.search(
    type: PODCAST_TYPE,
    body: query,
  ).then((response) => toPodcasts(response));
}

Future<List<Podcast>> searchPodcastsByTextQuery(textQuery) async {
  App app = App();
  final client = app.elasticClient;

  var query = {
    'query': {
      'bool': {
        'filter': [
          { 'exists': { 'field': 'feed' } },
        ],
        'should': [
          {
            'multi_match': {
              'fields': [
                'name^16',
                'artist.name^8',
                'genre^8',
                'description',
              ],
              'query': textQuery
            }
          }
        ]
      }
    }
  };
  return client.search(
    type: PODCAST_TYPE,
    body: query,
  ).then((response) => toPodcasts(response));
}

Future<void> subscribeToPodcast(Podcast podcast) async {
  final App app = App();
  PodcastSubscriptionBean subscriptionModel = app.models['podcast_subscription'];
  PodcastSubscription newSubscription = new PodcastSubscription(
    created: DateTime.now(),
    details: podcast.toJson(),
    isSubscribed: true,
    podcastId: podcast.id,
    podcastUrl: podcast.feed,
  );
  await subscriptionModel.insert(newSubscription);
}

List<Podcast> toPodcasts(ElasticsearchResponse response) {
  return response.hits.map((hit) => Podcast.fromJson(hit.source)).toList();
}
