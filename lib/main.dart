import 'dart:async';

import 'package:flutter/material.dart';

import 'package:hear2learn/app.dart';
import 'package:hear2learn/run_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final App app = App();
  await app.init(
    elasticHost: 'localhost:9200',
  );

  await start();
}
