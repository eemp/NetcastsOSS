import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/models/episode_download.dart';
import 'package:hear2learn/models/podcast_subscription.dart';
import 'package:hear2learn/redux/actions.dart';
import 'package:hear2learn/services/connectors/local_database.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App {
  static final App app = new App._internal();
  String downloadsPath;
  Episode episode;
  LocalDatabaseAdapter localDatabaseAdapter;
  Map<String, dynamic> models = new Map<String, dynamic>();
  AudioPlayer player = new AudioPlayer();
  SharedPreferences prefs;
  Store store;

  factory App() {
    return app;
  }

  App._internal();

  void init(Store appStore) async {
    store = appStore;
    prefs = await SharedPreferences.getInstance();
    //await prefs.clear();

    localDatabaseAdapter = new LocalDatabaseAdapter(await getApplicationLocalDatabasePath());
    await localDatabaseAdapter.init();

    downloadsPath = await getApplicationDownloadsPath();
    await Directory(downloadsPath).create(recursive: true);

    await initModels();

    initPlayer();
  }

  void initModels() async {
    models['episode_download'] = new EpisodeDownloadBean(this.localDatabaseAdapter.adapter);
    models['podcast_subscription'] = new PodcastSubscriptionBean(this.localDatabaseAdapter.adapter);

    await Future.forEach(models.values, (model) async {
      //await model.createTable();
      //await model.drop();
      await model.createTable(ifNotExists: true);
    });
  }

  void initPlayer() {
    //AudioPlayer.logEnabled = true;
    app.player.completionHandler = () {
      store.dispatch(Action(type: ActionType.CLEAR_EPISODE));
    };
    app.player.durationHandler = (Duration duration) {
      store.dispatch(Action(
        type: ActionType.SET_EPISODE_LENGTH,
        payload: {
          'length': duration,
        },
      ));
    };
    app.player.positionHandler = (Duration position) {
      store.dispatch(Action(
        type: ActionType.SET_EPISODE_POSITION,
        payload: {
          'position': position,
        },
      ));
    };
  }

  Future<String> getApplicationLocalDatabasePath() async {
    final String DB_NAME = 'hear2learn.db';
    Directory dbDir = await getApplicationDocumentsDirectory();
    return join(dbDir.path, DB_NAME);
  }

  Future<String> getApplicationDownloadsPath() async {
    final String DIR_NAME = 'downloads';
    Directory dbDir = await getApplicationDocumentsDirectory();
    return join(dbDir.path, DIR_NAME);
  }
}
