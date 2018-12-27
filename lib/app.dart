import 'dart:io';
import 'package:hear2learn/models/podcast_subscription.dart';
import 'package:hear2learn/services/connectors/local_database.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App {
  static final App app = new App._internal();
  LocalDatabaseAdapter localDatabaseAdapter;
  SharedPreferences prefs;
  Map<String, dynamic> models = new Map<String, dynamic>();

  factory App() {
    return app;
  }

  App._internal();

  void init() async {
    prefs = await SharedPreferences.getInstance();

    localDatabaseAdapter = new LocalDatabaseAdapter(await getApplicationLocalDatabasePath());
    await localDatabaseAdapter.init();


    await initModels();
  }

  void initModels() async {
    models['podcast_subscription'] = new PodcastSubscriptionBean(this.localDatabaseAdapter.adapter);

    await Future.forEach(models.values, (model) async {
      //await model.createTable();
      //await model.drop();
      await model.createTable(ifNotExists: true);
    });
  }

  static Future<String> getApplicationLocalDatabasePath() async {
    final String DB_NAME = 'hear2learn.db';
    Directory dbDir = await getApplicationDocumentsDirectory();
    return join(dbDir.path, DB_NAME);
  }
}

