import 'package:flutter_redux/flutter_redux.dart';
import 'package:hear2learn/app.dart';
import 'package:hear2learn/helpers/podcast.dart';
import 'package:hear2learn/models/podcast.dart';
import 'package:hear2learn/redux/state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

enum ActionType {
  CLEAR_EPISODE,
  PAUSE_EPISODE,
  PLAY_EPISODE,
  RESUME_EPISODE,
  SET_EPISODE_LENGTH,
  SET_EPISODE_POSITION,

  UPDATE_SUBSCRIPTIONS,
}

class Action {
  final ActionType type;
  final dynamic payload;

  Action({
    this.type,
    this.payload,
  });
}

Action pauseEpisode() {
  App app = App();

  app.player.pause();
  return Action(
    type: ActionType.PAUSE_EPISODE,
  );
}

Action playEpisode(episode) {
  App app = App();

  app.player.play(
    episode.download.downloadPath,
    isLocal: true,
  );
  return Action(
    type: ActionType.PLAY_EPISODE,
    payload: {
      'episode': episode,
    },
  );
}

Action resumeEpisode() {
  App app = App();

  app.player.resume();
  return Action(
    type: ActionType.RESUME_EPISODE,
  );
}

Action seekInEpisode(position) {
  App app = App();

  app.player.seek(position);
  return Action(
    type: ActionType.SET_EPISODE_POSITION,
    payload: {
      'position': position,
    },
  );
}

void updateSubscriptions(Store<AppState> store) async {
  final List<Podcast> subscriptions = await getSubscriptions();
  store.dispatch(
    Action(
      type: ActionType.UPDATE_SUBSCRIPTIONS,
      payload: {
        'subscriptions': subscriptions,
      },
    )
  );
}
