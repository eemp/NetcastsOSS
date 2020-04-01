import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hear2learn/app.dart';
import 'package:hear2learn/run_app.dart';
import 'package:hear2learn/services/connectors/remote_data.dart';
import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final App app = App();
  await app.init(
    remoteDataDB: openSqliteConnection(),
    remoteDataStrategy: SQLITE_STRATEGY,
  );

  await start();
}

LazyDatabase openSqliteConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    await loadLocalPodcastsDB();

    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(await getLocalPodcastsDBPath());
    return VmDatabase(file);
  });
}

void loadLocalPodcastsDB() async {
  // Construct a file path to copy database to
  String path = await getLocalPodcastsDBPath();

  // Only copy if the database doesn't exist
  if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
    // Load database from asset and copy
    ByteData data = await rootBundle.load(join('assets/data/podcasts.sqlite3'));
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    // Save copied asset to documents
    await new File(path).writeAsBytes(bytes);
  }
}

Future<String> getLocalPodcastsDBPath() async {
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  return join(documentsDirectory.path, "assets_data_podcasts.sqlite3");
}
