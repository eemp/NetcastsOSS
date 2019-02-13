import 'package:hear2learn/helpers/dash.dart' as dash;
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

Episode playingEpisodeSelector(Store<AppState> store) {
  final AppState state = store.state;
  return state.userEpisodes[state.playingEpisode];
}

List<Episode> downloadsSelector(Store<AppState> store) {
  return store.state.userEpisodes.values.where(
    (Episode episode) =>
      episode.downloadPath != null
        || episode.status == EpisodeStatus.DOWNLOADING
  ).toList();
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
