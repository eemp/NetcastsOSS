import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:hear2learn/helpers/dash.dart' as dash;
import 'package:hear2learn/models/episode.dart';
import 'package:hear2learn/models/episode_action.dart';
import 'package:hear2learn/models/podcast_subscription.dart';
import 'package:hear2learn/models/user_episode.dart';
import 'package:hear2learn/redux/actions.dart';
import 'package:hear2learn/redux/state.dart';
import 'package:hear2learn/redux/store.dart';
import 'package:hear2learn/services/connectors/local_database.dart';
import 'package:hear2learn/services/connectors/elastic.dart';
import 'package:package_info/package_info.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App {
  static final App app = App._internal();
  List<IAPItem> donations;
  String downloadsPath;
  ElasticsearchClient elasticClient;
  Episode episode;
  LocalDatabaseAdapter localDatabaseAdapter;
  Map<String, dynamic> models = <String, dynamic>{};
  PackageInfo packageInfo;
  SharedPreferences prefs;
  Store<AppState> store;
  StreamSubscription _purchaseUpdatedSubscription;

  factory App() {
    return app;
  }

  App._internal();

  Future<void> init() async {
    packageInfo = await PackageInfo.fromPlatform();

    store = appStore();

    localDatabaseAdapter = LocalDatabaseAdapter(await getApplicationLocalDatabasePath());
    await localDatabaseAdapter.init();

    prefs = await SharedPreferences.getInstance();
    //await prefs.clear();

    downloadsPath = await getApplicationDownloadsPath();
    await Directory(downloadsPath).create(recursive: true);

    initConnectivityListener();

    await initModels();

    await initDonations();
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

  void initConnectivityListener() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult connectivity) {
      store.dispatch(setConnectivity(connectivity));
    });
  }

  Future<void> initDonations() async {
    await FlutterInappPurchase.instance.initConnection;
    donations = await FlutterInappPurchase.instance.getProducts(['io.eemp.netcastsoss.donation.1', 'io.eemp.netcastsoss.donation.5']);
    _purchaseUpdatedSubscription = FlutterInappPurchase.purchaseUpdated.listen((PurchasedItem item) {
      FlutterInappPurchase.instance.consumePurchaseAndroid(item.purchaseToken);
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
      const Duration(milliseconds: 1000)
    );
    final Function throttledPositionHandler = dash.throttle(
      (Duration position) {
        store.dispatch(updateEpisodePosition(position));
      },
      const Duration(milliseconds: 1000)
    );
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
