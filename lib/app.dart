import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:hear2learn/helpers/dash.dart' as dash;
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/models/episode_download.dart';
import 'package:hear2learn/models/podcast_subscription.dart';
import 'package:hear2learn/redux/actions.dart';
import 'package:hear2learn/redux/state.dart';
import 'package:hear2learn/redux/store.dart';
import 'package:hear2learn/services/connectors/local_database.dart';
import 'package:hear2learn/services/api/elastic.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App {
  static final App app = App._internal();
  String downloadsPath;
  ElasticsearchClient elasticClient;
  Episode episode;
  LocalDatabaseAdapter localDatabaseAdapter;
  Map<String, dynamic> models = <String, dynamic>{};
  final AudioPlayer player = AudioPlayer();
  SharedPreferences prefs;
  Store<AppState> store;

  factory App() {
    return app;
  }

  App._internal();

  Future<void> init({ String elasticHost }) async {
    store = appStore();
    prefs = await SharedPreferences.getInstance();
    //await prefs.clear();

    localDatabaseAdapter = LocalDatabaseAdapter(await getApplicationLocalDatabasePath());
    await localDatabaseAdapter.init();

    elasticClient = ElasticsearchClient(
      host: elasticHost,
      index: 'hear2learn',
    );

    downloadsPath = await getApplicationDownloadsPath();
    await Directory(downloadsPath).create(recursive: true);

    await initModels();

    initPlayer();
  }

  Future<void> initModels() async {
    models['episode_download'] = EpisodeDownloadBean(localDatabaseAdapter.adapter);
    models['podcast_subscription'] = PodcastSubscriptionBean(localDatabaseAdapter.adapter);

    await Future.forEach<dynamic>(models.values, (dynamic model) async {
      //await model.createTable();
      //await model.drop();
      await model.createTable(ifNotExists: true);
    });
  }

  void initPlayer() {
    final Function throttledDurationHandler = dash.throttle(
      (Duration duration) {
        store.dispatch(Action(
          type: ActionType.SET_EPISODE_LENGTH,
          payload: <String, dynamic>{
            'length': duration,
          },
        ));
      },
      Duration(milliseconds: 1000)
    );
    final Function throttledPositionHandler = dash.throttle(
      (Duration position) {
        store.dispatch(Action(
          type: ActionType.SET_EPISODE_POSITION,
          payload: <String, dynamic>{
            'position': position,
          },
        ));
      },
      Duration(milliseconds: 1000)
    );


    //AudioPlayer.logEnabled = true;
    app.player.completionHandler = () {
      store.dispatch(Action(type: ActionType.CLEAR_EPISODE));
    };
    app.player.durationHandler = (Duration duration) {
      final List<dynamic> throttledUpdateArgs = <dynamic>[ duration ];
      throttledDurationHandler(throttledUpdateArgs);
    };
    app.player.positionHandler = (Duration position) {
      final List<dynamic> throttledUpdateArgs = <dynamic>[ position ];
      throttledPositionHandler(throttledUpdateArgs);
    };
  }

  Future<String> getApplicationLocalDatabasePath() async {
    const String DB_NAME = 'hear2learn.db';
    final Directory dbDir = await getApplicationDocumentsDirectory();
    return join(dbDir.path, DB_NAME);
  }

  Future<String> getApplicationDownloadsPath() async {
    const String DIR_NAME = 'downloads';
    final Directory dbDir = await getApplicationDocumentsDirectory();
    return join(dbDir.path, DIR_NAME);
  }
}
