import 'dart:async';

import 'package:hear2learn/app.dart';
import 'package:hear2learn/run_app.dart';

Future<void> main() async {
  final App app = App();
  await app.init(
    elasticHost: 'hear2learn.azurewebsites.net',
  );

  await start();
}
