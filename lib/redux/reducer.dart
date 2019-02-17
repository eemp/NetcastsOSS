import 'package:connectivity/connectivity.dart';
import 'package:hear2learn/helpers/dash.dart' as dash;
import 'package:hear2learn/models/app_settings.dart';
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/models/podcast.dart';
import 'package:hear2learn/redux/actions.dart';
import 'package:hear2learn/redux/state.dart';

AppState reducer(AppState state, dynamic action) {
  return AppState(
    connectivity: connectivityReducer(state.connectivity, action),
    playingEpisode: playingEpisodeReducer(state.playingEpisode, action),
    settings: settingsReducer(state.settings, action),
    subscriptions: subscriptionsReducer(state.subscriptions, action),
    userEpisodes: userEpisodesReducer(state, action),
  );
}

const Function AppReducer = reducer;

ConnectivityResult connectivityReducer(ConnectivityResult state, dynamic action) {
  switch(action.type) {
    case ActionType.UPDATE_CONNECTIVITY:
      return action.payload['connectivity'];
    default:
      return state;
  }
}

String playingEpisodeReducer(String state, dynamic action) {
  switch(action.type) {
    case ActionType.CLEAR_EPISODE:
      return '';
    case ActionType.DELETE_EPISODE:
      final Episode episode = action.payload['episode'];
      return episode.url == state ? '' : state;
    case ActionType.PLAY_EPISODE:
      return action.payload['episode'].url;
    case ActionType.RESUME_EPISODE:
      return state;
    default:
      return state;
  }
}

AppSettings settingsReducer(AppSettings state, dynamic action) {
  switch(action.type) {
    case ActionType.UPDATE_SETTINGS:
      return action.payload['settings'];
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

Map<String, Episode> userEpisodesReducer(AppState appState, dynamic action) {
  final Map<String, Episode> state = appState.userEpisodes;
  final Episode playingEpisode = dash.isNotEmpty(appState.playingEpisode)
    ? state[appState.playingEpisode]
    : null;

  switch(action.type) {
    case ActionType.DOWNLOAD_EPISODE:
    case ActionType.UPDATE_DOWNLOAD_STATUS:
      final Episode episode = action.payload['episode'];
      final double progress = action.payload['progress'];
      final Episode matchingEpisode = state[episode.url] ?? episode;
      return Map<String, Episode>.from(state)..addAll(<String, Episode>{
        '${matchingEpisode.url}': matchingEpisode.copyWith(
          progress: progress ?? 0.0,
          status: EpisodeStatus.DOWNLOADING,
        ),
      });
    case ActionType.FINISH_DOWNLOADING_EPISODE:
      final Episode episode = action.payload['episode'];
      final Episode matchingEpisode = state[episode.url] ?? episode;
      return Map<String, Episode>.from(state)..addAll(<String, Episode>{
        '${episode.url}': matchingEpisode.copyWith(
          downloadPath: episode.downloadPath ?? matchingEpisode.downloadPath,
          position: Duration(),
          progress: 1.0,
          status: EpisodeStatus.DOWNLOADED,
        ),
      });
    case ActionType.DELETE_EPISODE:
      final Episode episode = action.payload['episode'];
      final Episode matchingEpisode = state[episode.url] ?? episode;
      return Map<String, Episode>.from(state)..addAll(<String, Episode>{
        '${matchingEpisode.url}': matchingEpisode.copyWith(
          downloadPath: '',
          status: EpisodeStatus.DELETED,
        ),
      });
    case ActionType.FAVORITE_EPISODE:
    case ActionType.UNFAVORITE_EPISODE:
      final Episode episode = action.payload['episode'];
      final Episode matchingEpisode = state[episode.url] ?? episode;
      return Map<String, Episode>.from(state)..addAll(<String, Episode>{
        '${matchingEpisode.url}': matchingEpisode.copyWith(
          isFavorited: action.type == ActionType.FAVORITE_EPISODE,
        ),
      });
    case ActionType.FINISH_EPISODE:
    case ActionType.UNFINISH_EPISODE:
      final Episode episode = action.payload['episode'];
      final Episode matchingEpisode = state[episode.url] ?? episode;
      return Map<String, Episode>.from(state)..addAll(<String, Episode>{
        '${matchingEpisode.url}': matchingEpisode.copyWith(
          isFinished: action.type == ActionType.FINISH_EPISODE,
        ),
      });
    case ActionType.UPDATE_DOWNLOADS:
      return state..addEntries(
        List<Episode>.from(action.payload['downloads']).map(
          (Episode userEpisode) => MapEntry<String, Episode>(userEpisode.url, userEpisode)
        ).toList()
      );
    case ActionType.PAUSE_EPISODE:
      final Episode episode = action.payload['episode'];
      final Episode matchingEpisode = state[episode.url] ?? episode;
      return Map<String, Episode>.from(state)..addAll(<String, Episode>{
        '${matchingEpisode.url}': matchingEpisode.copyWith(
          status: matchingEpisode.isPlayedToEnd()
            ? EpisodeStatus.PLAYED
            : EpisodeStatus.PAUSED,
        ),
      });
    case ActionType.PLAY_EPISODE:
      final Episode episode = action.payload['episode'];
      return state..addEntries(
        List<Episode>.from(state.values).map(
          (Episode userEpisode) =>
            MapEntry<String, Episode>(
              userEpisode.url,
              userEpisode.url == episode.url
                ? userEpisode.copyWith(status: EpisodeStatus.PLAYING)
                : userEpisode.copyWith(
                  status: userEpisode.status == EpisodeStatus.PLAYING
                    ? EpisodeStatus.PAUSED
                    : userEpisode.status
                )
            )
        ).toList()
      );
    case ActionType.RESUME_EPISODE:
      return Map<String, Episode>.from(state)..addAll(<String, Episode>{
        '${playingEpisode.url}': playingEpisode.copyWith(
          status: EpisodeStatus.PLAYING
        ),
      });
    case ActionType.SET_EPISODE_LENGTH:
      return playingEpisode != null
        ? (Map<String, Episode>.from(state)..addAll(<String, Episode>{
          '${playingEpisode.url}': playingEpisode.copyWith(
            length: action.payload['length'],
          ),
        }))
        : state;
    case ActionType.SET_EPISODE_POSITION:
      return playingEpisode != null
        ? (Map<String, Episode>.from(state)..addAll(<String, Episode>{
          '${playingEpisode.url}': playingEpisode.copyWith(
            position: action.payload['position'],
          ),
        }))
        : state;
    default:
      return state;
  }
}
