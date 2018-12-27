import 'dart:io';

import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';
import 'package:path_provider/path_provider.dart';

class LocalDatabaseAdapter {
  final String path;
  SqfliteAdapter adapter;

  // _cache is library-private, thanks to
  // the _ in front of its name.
  static final Map<String, LocalDatabaseAdapter> _cache =
      <String, LocalDatabaseAdapter>{};

  factory LocalDatabaseAdapter(String path) {
    if (_cache.containsKey(path)) {
      return _cache[path];
    } else {
      final adapter = LocalDatabaseAdapter._internal(path);
      _cache[path] = adapter;
      return adapter;
    }
  }

  LocalDatabaseAdapter._internal(this.path);

  void init() async {
    adapter = new SqfliteAdapter(this.path);
    await adapter.connect();
  }
}
