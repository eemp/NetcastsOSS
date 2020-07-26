// ignore_for_file: always_specify_types
import 'dart:async';

import 'package:hear2learn/app.dart';
import 'package:hear2learn/services/connectors/elastic.dart';
import 'package:hear2learn/models/podcast.dart';
import 'package:hear2learn/models/podcast_subscription.dart';
import 'package:netcastsoss_data_api/api.dart';
import 'package:netcastsoss_data_api/model/podcasts_filter.dart';

const String PODCAST_TYPE = 'podcast';

var jaguarApiGen = NetcastsossDataApi();

Future<List<Podcast>> getSubscriptions() {
  final App app = App();
  final PodcastSubscriptionBean subscriptionModel = app.models['podcast_subscription'];

  return subscriptionModel.findWhere(subscriptionModel.isSubscribed.eq(true)).then((response) {
    return Future.wait(response.map((subscription) => Future.value(subscription.getPodcastFromDetails())));
  });
}

Future<List<dynamic>> fetchPopularPodcastsByGenre() async {
  var api_instance = jaguarApiGen.getPodcastsControllerApi();
  var result = await api_instance.podcastsControllerFindPopularPodcasts(null);
  return result
    .map((podcastsByGenre) => ({
      'genre': podcastsByGenre.genre,
      'items': remotePodcastsToPodcasts(podcastsByGenre.items),
    }))
    .toList();
}

Future<List<Podcast>> searchPodcastsByTextQuery(String textQuery, { int pageSize = 10, int page = 0 }) async {
  var api_instance = jaguarApiGen.getPodcastsControllerApi();
  var result = await api_instance.podcastsControllerSearchPodcastsByText(textQuery, PodcastsFilter(
    skip: page * pageSize,
    limit: pageSize,
  ));
  return remotePodcastsToPodcasts(result);
}

List<Podcast> remotePodcastsToPodcasts(remotePodcasts) {
  return remotePodcasts.map<Podcast>((remotePodcast) =>
    Podcast.fromRemote(remotePodcast)
  ).toList();
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
