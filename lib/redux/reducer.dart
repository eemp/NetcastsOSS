import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/models/podcast.dart';
import 'package:hear2learn/redux/actions.dart';
import 'package:hear2learn/redux/state.dart';

AppState reducer(AppState state, dynamic action) {
  return AppState(
    playingEpisode: playingEpisodeReducer(state.playingEpisode, action),
    subscriptions: subscriptionsReducer(state.subscriptions, action),
    userEpisodes: userEpisodesReducer(state.userEpisodes, action),
  );
}

const Function AppReducer = reducer;

Episode playingEpisodeReducer(Episode state, dynamic action) {
  switch(action.type) {
    case ActionType.CLEAR_EPISODE:
      return null;
    case ActionType.PAUSE_EPISODE:
      return state.copyWith(
        status: state.isPlayedToEnd()
          ? EpisodeStatus.PLAYED
          : EpisodeStatus.PAUSED,
      );
    case ActionType.PLAY_EPISODE:
      return action.payload['episode'].copyWith(
        status: EpisodeStatus.PLAYING,
      );
    case ActionType.RESUME_EPISODE:
      return state.copyWith(
        status: EpisodeStatus.PLAYING,
      );
    case ActionType.SET_EPISODE_LENGTH:
      return state?.copyWith(
        length: action.payload['length'],
      );
    case ActionType.SET_EPISODE_POSITION:
      return state?.copyWith(
        position: action.payload['position'],
      );
    default:
      return state;
  }
}

List<Podcast> subscriptionsReducer(List<Podcast> state, dynamic action) {
  switch(action.type) {
    case ActionType.UPDATE_SUBSCRIPTIONS:
      return action.payload['subscriptions'];
    default:
      return state;
  }
}

Map<String, Episode> userEpisodesReducer(Map<String, Episode> state, dynamic action) {
  switch(action.type) {
    case ActionType.PAUSE_EPISODE:
      final Episode episode = action.payload['episode'];
      return Map<String, Episode>.from(state)..addAll(<String, Episode>{
        '${episode.url}': episode.copyWith(
          status: episode.isPlayedToEnd()
            ? EpisodeStatus.PLAYED
            : EpisodeStatus.PAUSED,
        ),
      });
    case ActionType.DELETE_EPISODE:
      final Episode episode = action.payload['episode'];
      return Map<String, Episode>.from(state)..addAll(<String, Episode>{
        '${episode.url}': episode.copyWith(
          downloadPath: null,
        ),
      });
    case ActionType.DOWNLOAD_EPISODE:
    case ActionType.FINISH_DOWNLOADING_EPISODE:
      final Episode episode = action.payload['episode'];
      return Map<String, Episode>.from(state)..addAll(<String, Episode>{
        '${episode.url}': episode,
      });
    case ActionType.UPDATE_DOWNLOAD_STATUS:
      final Episode episode = action.payload['episode'];
      final double progress = action.payload['progress'];
      final Episode matchingEpisode = state[episode.url];
      if(matchingEpisode != null) {
        matchingEpisode.progress = progress;
      }
      return state;
    case ActionType.UPDATE_DOWNLOADS:
      return state..addEntries(
        List<Episode>.from(action.payload['downloads']).map(
          (Episode userEpisode) => MapEntry<String, Episode>(userEpisode.url, userEpisode)
        ).toList()
      );
    default:
      return state;
  }
}
