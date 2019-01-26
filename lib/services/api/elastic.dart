import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

class ElasticsearchClient {
  static const String SEARCH_ROUTE = '_search';

  final String host;
  final String index;

  const ElasticsearchClient({
    this.host,
    this.index,
  });

  Future<ElasticsearchResponse> search({
    Map<String, dynamic> body,
    String index,
    String query,
    String type,
  }) async {
    index ??= this.index;
    final String path = getPath(index, type, SEARCH_ROUTE);
    final Uri uri = query != null
      ? Uri.https(host, path, <String, String>{ 'q': query })
      : Uri.https(host, path);
    final dynamic response = await http.post(uri,
      body: json.encode(body),
      headers: <String, String>{ 'Content-Type': 'application/json' }
    );
    return compute<String, ElasticsearchResponse>(parseResponse, response.body);
  }

  static String getPath(String index, String type, String route) {
    final List<String> types = type is List
      ? type
      : <String>[ type ];
    return <String>[ index, types.join(','), route ].join('/');
  }
}

class ElasticsearchResponse {
  int total = 0;
  List<Hit> hits = <Hit>[];

  ElasticsearchResponse.fromJson(Map<String, dynamic> json) {
    if(json['hits'] != null) {
      final List<Map<String, dynamic>> rawHits = json['hits']['hits'];
      hits = rawHits.map((Map<String, dynamic> result) => Hit.fromJson(result)).toList();
      total = json['hits']['total'];
    }
  }
}

class Hit {
  // looks like dart doesn't create getters
  // for underscore prefixed variables
  String id;
  double score;
  Map<String, dynamic> source;
  String type;

  Hit.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    score = json['_score'];
    source = json['_source'];
    type = json['_type'];
  }
}

ElasticsearchResponse parseResponse(String responseBody) {
  final Map<String, dynamic> parsedContent = json.decode(responseBody);
  return ElasticsearchResponse.fromJson(parsedContent);
}
