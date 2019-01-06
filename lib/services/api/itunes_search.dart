import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

class ITunesSearchAPI {
  static final AUTHORITY = 'itunes.apple.com';
  static final PATH = '/search';

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
    defaultQueryOptions = {
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
    final queryOptions = options ?? defaultQueryOptions;
    final uri = Uri.https(AUTHORITY, PATH, { 'term': query }..addAll(queryOptions));
    final response = await http.get(uri);
    return compute(parseResults, response.body);
  }
}

class ITunesSearchAPIResult {
  final String artistName;
  final String artworkUrl;
  final String collectionName;
  final String feedUrl;
  List<ITunesSearchAPIGenre> genres;
  final String kind;
  final DateTime releaseDate;

  ITunesSearchAPIResult.fromJson(Map<String, dynamic> json)
    : artistName = json['artistName'],
      artworkUrl = json['artworkUrl600'],
      collectionName = json['collectionName'],
      feedUrl = json['feedUrl'],
      genres = (json['genres'] as List).asMap().entries.map(
        (entry) => ITunesSearchAPIGenre(id: json['genreIds'][entry.key], name: entry.value)
      ).toList(),
      kind = json['kind'],
      releaseDate = DateTime.parse(json['releaseDate']);
}

class ITunesSearchAPIGenre {
  final String id;
  final String name;

  ITunesSearchAPIGenre({
    this.id,
    this.name,
  });
}

List<ITunesSearchAPIResult> parseResults(responseBody) {
  final parsedContent = json.decode(responseBody);
  return (parsedContent['results'] as List).map((result) => ITunesSearchAPIResult.fromJson(result)).toList();
}
