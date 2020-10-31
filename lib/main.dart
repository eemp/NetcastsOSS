import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hear2learn/app.dart';
import 'package:hear2learn/run_app.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final App app = App();
  await app.init();

  await start();
}
