import 'package:hear2learn/app.dart';

enum ActionType {
  CLEAR_EPISODE,
  PAUSE_EPISODE,
  PLAY_EPISODE,
  RESUME_EPISODE,
  SET_EPISODE_LENGTH,
  SET_EPISODE_POSITION,
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
