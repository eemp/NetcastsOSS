import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/redux/actions.dart';
import 'package:hear2learn/redux/state.dart';
import 'package:redux/redux.dart';

AppState AppReducer(AppState state, dynamic action) {
  return AppState(
    episodeLength: episodeLengthReducer(state.episodeLength, action),
    isPlaying: isPlayingReducer(state.isPlaying, action),
    playingEpisode: playEpisodeReducer(state.playingEpisode, action),
    positionInEpisode: positionInEpisodeReducer(state.positionInEpisode, action),
  );
}

bool isPlayingReducer(state, dynamic action) {
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

Episode playEpisodeReducer(state, dynamic action) {
  switch(action.type) {
    case ActionType.CLEAR_EPISODE:
      return null;
    case ActionType.PLAY_EPISODE:
      return action.payload['episode'];
    default:
      return state;
  }
}

Duration episodeLengthReducer(state, dynamic action) {
  switch(action.type) {
    case ActionType.CLEAR_EPISODE:
      return null;
    case ActionType.SET_EPISODE_LENGTH:
      return action.payload['length'];
    default:
      return state;
  }
}

Duration positionInEpisodeReducer(state, dynamic action) {
  switch(action.type) {
    case ActionType.CLEAR_EPISODE:
      return null;
    case ActionType.SET_EPISODE_POSITION:
      return action.payload['position'];
    default:
      return state;
  }
}
