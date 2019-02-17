import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:connectivity/connectivity.dart';
import 'package:local_notifications/local_notifications.dart';
import 'package:hear2learn/helpers/dash.dart' as dash;
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/models/episode_action.dart';
import 'package:hear2learn/models/podcast_subscription.dart';
import 'package:hear2learn/models/user_episode.dart';
import 'package:hear2learn/redux/actions.dart';
import 'package:hear2learn/redux/state.dart';
import 'package:hear2learn/redux/store.dart';
import 'package:hear2learn/services/connectors/local_database.dart';
import 'package:hear2learn/services/api/elastic.dart';
import 'package:package_info/package_info.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App {
  static final App app = App._internal();
  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    id: 'default_notification',
    name: 'Default',
    description: 'Grant this app the ability to show notifications',
    importance: AndroidNotificationChannelImportance.HIGH,
  );
  String downloadsPath;
  ElasticsearchClient elasticClient;
  Episode episode;
  LocalDatabaseAdapter localDatabaseAdapter;
  Map<String, dynamic> models = <String, dynamic>{};
  PackageInfo packageInfo;
  final AudioPlayer player = AudioPlayer();
  SharedPreferences prefs;
  Store<AppState> store;

  factory App() {
    return app;
  }

  App._internal();

  Future<void> init({ String elasticHost }) async {
    packageInfo = await PackageInfo.fromPlatform();

    store = appStore();

    elasticClient = ElasticsearchClient(
      host: elasticHost,
      index: 'hear2learn',
    );

    localDatabaseAdapter = LocalDatabaseAdapter(await getApplicationLocalDatabasePath());
    await localDatabaseAdapter.init();

    prefs = await SharedPreferences.getInstance();
    //await prefs.clear();

    downloadsPath = await getApplicationDownloadsPath();
    await Directory(downloadsPath).create(recursive: true);

    await initModels();

    await initNotifications();

    initPlayer();
  }

  Future<void> initModels() async {
    models['episode_action'] = EpisodeActionBean(localDatabaseAdapter.adapter);
    models['podcast_subscription'] = PodcastSubscriptionBean(localDatabaseAdapter.adapter);
    models['user_episode'] = UserEpisodeBean(localDatabaseAdapter.adapter);

    await Future.forEach<dynamic>(models.values, (dynamic model) async {
      //await model.createTable();
      //await model.drop();
      await model.createTable(ifNotExists: true);
    });
  }

  Future<void> initNotifications() async {
    await LocalNotifications.createAndroidNotificationChannel(channel: channel);
  }

  void initConnectivityListener() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult connectivity) {
      store.dispatch(setConnectivity(connectivity));
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
        store.dispatch(updateEpisodePosition(position));
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

  Future<void> createNotification({
    String actionText,
    Function callback,
    String content,
    bool isOngoing = false,
    bool launchesApp = false,
    String payload,
    String title,
  }) async {
    //await LocalNotifications.removeNotification(0);
    await LocalNotifications.createNotification(
      actions: <NotificationAction>[
        NotificationAction(
          actionText: actionText,
          callback: callback,
          callbackName: 'onNotificationActionClick',
          payload: payload,
          launchesApp: launchesApp,
        ),
      ],
      androidSettings: AndroidSettings(
        channel: channel,
        isOngoing: isOngoing,
      ),
      content: content,
      id: 0,
      title: title,
    );
  }
}
