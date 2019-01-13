import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:hear2learn/models/episode_download.dart';
import 'package:hear2learn/models/podcast_subscription.dart';
import 'package:hear2learn/services/connectors/local_database.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App {
  static final App app = new App._internal();
  String downloadsPath;
  LocalDatabaseAdapter localDatabaseAdapter;
  Map<String, dynamic> models = new Map<String, dynamic>();
  AudioPlayer player = new AudioPlayer();
  SharedPreferences prefs;

  factory App() {
    return app;
  }

  App._internal();

  void init() async {
    prefs = await SharedPreferences.getInstance();

    localDatabaseAdapter = new LocalDatabaseAdapter(await getApplicationLocalDatabasePath());
    await localDatabaseAdapter.init();

    downloadsPath = await getApplicationDownloadsPath();
    await Directory(downloadsPath).create(recursive: true);

    await initModels();
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
