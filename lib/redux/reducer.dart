import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/models/podcast.dart';
import 'package:hear2learn/redux/actions.dart';
import 'package:hear2learn/redux/state.dart';

AppState reducer(AppState state, dynamic action) {
  return AppState(
    episodeLength: episodeLengthReducer(state.episodeLength, action),
    isPlaying: isPlayingReducer(state.isPlaying, action),
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
