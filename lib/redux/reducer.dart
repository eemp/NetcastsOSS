import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/models/podcast.dart';
import 'package:hear2learn/redux/actions.dart';
import 'package:hear2learn/redux/state.dart';

AppState reducer(AppState state, dynamic action) {
  return AppState(
    downloads: downloadsReducer(state.downloads, action),
    episodeLength: episodeLengthReducer(state.episodeLength, action),
    isPlaying: isPlayingReducer(state.isPlaying, action),
    pendingDownloads: pendingDownloadsReducer(state.pendingDownloads, action),
    playingEpisode: playEpisodeReducer(state.playingEpisode, action),
    positionInEpisode: positionInEpisodeReducer(state.positionInEpisode, action),
    subscriptions: subscriptionsReducer(state.subscriptions, action),
  );
}

const Function AppReducer = reducer;

bool isPlayingReducer(bool state, dynamic action) {
  switch(action.type) {
    case ActionType.CLEAR_EPISODE:
      return false;
    case ActionType.PAUSE_EPISODE:
      return false;
    case ActionType.PLAY_EPISODE:
    case ActionType.RESUME_EPISODE:
      return true;
    default:
      return state;
  }
}

Episode playEpisodeReducer(Episode state, dynamic action) {
  switch(action.type) {
    case ActionType.CLEAR_EPISODE:
      return null;
    case ActionType.PLAY_EPISODE:
      return action.payload['episode'];
    default:
      return state;
  }
}

Duration episodeLengthReducer(Duration state, dynamic action) {
  switch(action.type) {
    case ActionType.PLAY_EPISODE:
    case ActionType.CLEAR_EPISODE:
      return null;
    case ActionType.SET_EPISODE_LENGTH:
      return action.payload['length'];
    default:
      return state;
  }
}

Duration positionInEpisodeReducer(Duration state, dynamic action) {
  switch(action.type) {
    case ActionType.PLAY_EPISODE:
    case ActionType.CLEAR_EPISODE:
      return null;
    case ActionType.SET_EPISODE_POSITION:
      return action.payload['position'];
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

List<Episode> downloadsReducer(List<Episode> state, dynamic action) {
  switch(action.type) {
    case ActionType.DELETE_EPISODE:
      return state.where((Episode download) => download.url != action.payload['episode'].url).toList();
    case ActionType.FINISH_DOWNLOADING_EPISODE:
      return state..add(action.payload['episode']);
    case ActionType.UPDATE_DOWNLOADS:
      return action.payload['downloads'];
    default:
      return state;
  }
}

List<Episode> pendingDownloadsReducer(List<Episode> state, dynamic action) {
  switch(action.type) {
    case ActionType.DOWNLOAD_EPISODE:
      return List<Episode>.from(state)..add(action.payload['episode']);
    case ActionType.FINISH_DOWNLOADING_EPISODE:
      final Episode episode = action.payload['episode'];
      return state.where((Episode pendingDownload) => pendingDownload.url != episode.url).toList();
    case ActionType.UPDATE_DOWNLOAD_STATUS:
      final Episode episode = action.payload['episode'];
      final double progress = action.payload['progress'];
      final int matchingIndex = state.indexWhere((Episode pendingDownload) => pendingDownload.url == episode.url);
      if(matchingIndex >= 0) {
        final Episode matchingDownload = state[matchingIndex];
        matchingDownload.progress = progress;
      }
      return state;
    case ActionType.UPDATE_PENDING_DOWNLOADS:
      return action.payload['downloads'];
    default:
      return state;
  }
}
