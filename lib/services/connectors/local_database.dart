import 'dart:async';

import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

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
      final LocalDatabaseAdapter adapter = LocalDatabaseAdapter._internal(path);
      _cache[path] = adapter;
      return adapter;
    }
  }

  LocalDatabaseAdapter._internal(this.path);

  Future<void> init() async {
    adapter = SqfliteAdapter(path);
    await adapter.connect();
  }
}
