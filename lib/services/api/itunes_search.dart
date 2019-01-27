import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

class ITunesSearchAPI {
  static const String AUTHORITY = 'itunes.apple.com';
  static const String PATH = '/search';

  String country;
  String entity;
  String lang;
  int limit;
  String media;

  Map<String, String> defaultQueryOptions;

  ITunesSearchAPI({
    this.country = 'US',
    this.entity = 'podcast',
    this.lang = 'en_us',
    this.limit = 20,
    this.media = 'podcast',
  }) {
    defaultQueryOptions = <String, String>{
      'country': country,
      'entity': entity,
      'lang': lang,
      'limit': limit.toString(),
      'media': media,
    };
  }

  /// Search for results from iTunes
  ///
  /// Future<dynamic> results = api.search(query, media: 'podcast', ...);
  Future<List<ITunesSearchAPIResult>> search(String query, [ Map<String, String> options ]) async {
    final Map<String, String> queryOptions = options ?? defaultQueryOptions;
    final Uri uri = Uri.https(AUTHORITY, PATH, <String, String>{ 'term': query }..addAll(queryOptions));
    return compute(parseResults, (await http.get(uri)).body);
  }
}

class ITunesSearchAPIResult {
  final String artistName;
  final String artworkUrl;
  final String collectionName;
  final String description;
  final String feedUrl;
  List<ITunesSearchAPIGenre> genres;
  final String kind;
  final DateTime releaseDate;
  final int trackCount;

  ITunesSearchAPIResult.fromJson(Map<String, dynamic> json)
    : artistName = json['artistName'],
      artworkUrl = json['artworkUrl600'],
      collectionName = json['collectionName'],
      description = json['description'],
      feedUrl = json['feedUrl'],
      //genres = (json['genres'] as List).asMap().entries.map(
        //(Map<String, String> entry) => ITunesSearchAPIGenre(id: json['genreIds'][entry.key], name: entry.value)
      //).toList(),
      kind = json['kind'],
      releaseDate = DateTime.parse(json['releaseDate']),
      trackCount = json['trackCount'];
}

class ITunesSearchAPIGenre {
  final String id;
  final String name;

  ITunesSearchAPIGenre({
    this.id,
    this.name,
  });
}

List<ITunesSearchAPIResult> parseResults(String responseBody) {
  final Map<String, dynamic> parsedContent = json.decode(responseBody);
  final List<dynamic> results = parsedContent['results'];
  return results.map((dynamic result) => ITunesSearchAPIResult.fromJson(result)).toList();
}
