// ignore_for_file: always_specify_types
import 'dart:async';

import 'package:hear2learn/app.dart';
import 'package:hear2learn/services/connectors/elastic.dart';
import 'package:hear2learn/models/podcast.dart';
import 'package:hear2learn/models/podcast_subscription.dart';
import 'package:hear2learn/services/connectors/remote_data.dart' as pv2;

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
  final pv2.RemoteData remoteData = app.remoteData;

  return remoteData.podcastsByGenre(genreId).catchError((err, stack) {
    print('searchPodcastsByGenre: Ran into error: ' + err.toString());
    print(stack.toString());
    return err;
  });
}

Future<List<Podcast>> searchPodcastsByTextQuery(String textQuery, { int pageSize = 10, int page = 0 }) async {
  final App app = App();
  final pv2.RemoteData remoteData = app.remoteData;

  return remoteData.searchPodcastsByTextQuery(textQuery, pageSize: pageSize, page: page).catchError((err, stack) {
    print('searchPodcastsByTextQuery: Ran into error: ' + err.toString());
    print(stack.toString());
    return err;
  });
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
