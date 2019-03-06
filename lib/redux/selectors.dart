import 'package:hear2learn/helpers/dash.dart' as dash;
import 'package:hear2learn/models/app_settings.dart';
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/models/podcast.dart';
import 'package:hear2learn/redux/state.dart';
import 'package:redux/redux.dart';

Function getEpisodeSelector(Episode episode) {
  return (Store<AppState> store) {
    final AppState state = store.state;
    final Episode userEpisode = state.userEpisodes[episode.url];
    final Episode selectedEpisode = userEpisode ?? episode;
    return selectedEpisode;
  };
}

int sortFavoritedEpisodes(Episode a, Episode b) {
  if (a.podcastTitle != b.podcastTitle) {
    return a.podcastTitle.compareTo(b.podcastTitle);
  }
  return a.title.compareTo(b.title);
}

List<Episode> downloadsSelector(Store<AppState> store) {
  return store.state.userEpisodes.values.where(
    (Episode episode) =>
      dash.isNotEmpty(episode.downloadPath)
        || episode.status == EpisodeStatus.DOWNLOADING
  ).toList();
}

List<Episode> queueSelector(Store<AppState> store) {
  final EpisodeQueue episodeQueue = store.state.settings.episodeQueue;
  // ignore: prefer_collection_literals
  final Map<EpisodeQueue, Function> selectors = Map<EpisodeQueue, Function>();
  selectors.addEntries(<MapEntry<EpisodeQueue, Function>>[
    const MapEntry<EpisodeQueue, Function>(EpisodeQueue.DOWNLOADS, unplayedDownloadsSelector),
    const MapEntry<EpisodeQueue, Function>(EpisodeQueue.PODCAST, unplayedPodcastEpisodesSelector),
  ]);

  final Episode playingEpisode = playingEpisodeSelector(store);
  final List<Episode> queue = selectors[episodeQueue] != null
    ? selectors[episodeQueue](store)
    : <Episode>[];
  return playingEpisode != null
    ? (
      List<Episode>.from(<Episode>[
        playingEpisode,
      ])..addAll(queue.where((Episode queuedEpisode) => queuedEpisode.url != playingEpisode.url))
    )
    : queue
    ;
}

List<Episode> unplayedDownloadsSelector(Store<AppState> store) {
  return store.state.userEpisodes.values.where(
    (Episode episode) =>
      dash.isNotEmpty(episode.downloadPath)
        && episode.status != EpisodeStatus.PLAYED
  ).toList();
}

List<Episode> unplayedPodcastEpisodesSelector(Store<AppState> store) {
  final String currentPodcast = store.state.settings.currentPodcast;
  return store.state.userEpisodes.values.where(
    (Episode episode) =>
      dash.isNotEmpty(episode.downloadPath)
        && episode.podcastUrl == currentPodcast
        && episode.status != EpisodeStatus.PLAYED
  ).toList();
}

List<Episode> favoritesSelector(Store<AppState> store) {
  final List<Episode> favorites = store.state.userEpisodes.values.where(
    (Episode episode) => episode.isFavorited
  ).toList();
  favorites.sort(sortFavoritedEpisodes);
  return favorites;
}

Episode playingEpisodeSelector(Store<AppState> store) {
  final String playingEpisode = store.state.playingEpisode;
  final Map<String, Episode> userEpisodes = store.state.userEpisodes;
  return dash.isNotEmpty(playingEpisode)
    ? userEpisodes[playingEpisode]
    : null;
}

List<Podcast> subscriptionsSelector(Store<AppState> store) {
  return store.state.subscriptions;
}

Function getSubscriptionSelector(Podcast potentialSubscription) {
  return (Store<AppState> store) {
    final AppState state = store.state;
    return dash.find(state.subscriptions, (Podcast podcast) => podcast.feed == potentialSubscription.feed);
  };
}

AppSettings settingsSelector(Store<AppState> store) {
  return store.state.settings;
}
