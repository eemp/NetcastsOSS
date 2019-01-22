import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

class ElasticsearchClient {
  static final String SEARCH_ROUTE = '_search';

  String host;
  String index;

  ElasticsearchClient({
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
    var path = getPath(index, type, SEARCH_ROUTE);
    var uri = query != null
      ? Uri.https(host, path, { 'q': query })
      : Uri.https(host, path);
    var response = await http.post(uri, body: json.encode(body), headers: { 'Content-Type': 'application/json' });
    return compute(parseResponse, response.body);
  }

  static String getPath(index, type, route) {
    var types = type is List
      ? type
      : [ type ];
    return [ index, types.join(','), route ].join('/');
  }
}

class ElasticsearchResponse {
  int total = 0;
  List<Hit> hits = new List<Hit>();

  ElasticsearchResponse.fromJson(json) {
    if(json['hits'] != null) {
      hits = (json['hits']['hits'] as List).map((result) => Hit.fromJson(result)).toList();
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

  Hit.fromJson(json) {
    id = json['_id'];
    score = json['_score'];
    source = json['_source'];
    type = json['_type'];
  }
}

ElasticsearchResponse parseResponse(responseBody) {
  final parsedContent = json.decode(responseBody);
  return ElasticsearchResponse.fromJson(parsedContent);
}
