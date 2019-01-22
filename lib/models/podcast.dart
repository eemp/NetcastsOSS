import 'dart:convert';

import 'package:hear2learn/models/episode.dart';

class Artist {
  String id;
  String name;

  Artist({
    this.id,
    this.name,
  });

  Artist.fromJson(json) {
    this.id = json['id'].toString();
    this.name = json['name'];
  }

  String toJson() {
    return jsonEncode({
      'id': id,
      'name': name,
    });
  }
}

class Genre {
  String id;
  String name;

  Genre({
    this.id,
    this.name,
  });

  Genre.fromJson(json) {
    this.id = json['id'].toString();
    this.name = json['name'];
  }

  String toJson() {
    return jsonEncode({
      'id': id,
      'name': name,
    });
  }
}

class Podcast {
  Artist artist;
  String artwork30;
  String artwork60;
  String artwork100;
  String artwork600;
  String artworkOrig;
  String description;
  List<Episode> episodes;
  int episodesCount;
  String feed;
  List<Genre> genres;
  String id;
  DateTime lastModifiedDate;
  String logoUrl; // TODO: to be deprecated, removed
  String name;
  int popularity;
  String title; // TODO: to be deprecated, removed
  DateTime releaseDate;
  String url; // TODO: to be deprecated, removed

  Podcast({
    this.artwork30,
    this.artwork60,
    this.artwork100,
    this.artwork600,
    this.artworkOrig,
    this.description,
    this.episodes,
    this.episodesCount,
    this.feed,
    this.id,
    this.lastModifiedDate,
    this.logoUrl, // TODO: to be deprecated, removed
    this.name,
    this.popularity,
    this.releaseDate,
    this.title, // todo: to be deprecated, removed
    this.url, // todo: to be deprecated, removed
  });

  Podcast.fromJson(json) {
    //this.artist = Artist.fromJson(json['artist']);
    this.artwork30 = json['artwork30'];
    this.artwork60 = json['artwork60'];
    this.artwork100 = json['artwork100'];
    this.artwork600 = json['artwork600'];
    this.artworkOrig = json['artworkOrig'];
    this.description = json['description'];
    //this.episodesCount = json['episodes']['count'];
    this.feed = json['feed'];
    //this.genres = (json['genres'] as List).map((genreJson) => Genre.fromJson(genreJson)).toList();
    this.id = json['id'].toString();
    //this.lastModifiedDate = DateTime(json['last_modified_date']);
    this.name = json['name'];
    //this.popularity = json['popularity'];
    //this.releaseDate = DateTime(json['release_date']);
  }

  String toJson() {
    return jsonEncode({
      'artist': artist,
      'artwork30': artwork30,
      'artwork60': artwork60,
      'artwork100': artwork100,
      'artwork600': artwork600,
      'artworkOrig': artworkOrig,
      'description': description,
      'episodesCount': episodesCount,
      'feed': feed,
      'genres': genres,
      'id': id,
      'name': name,
      'popularity': popularity,
    });
  }

  @override
  String toString() {
    return 'Podcast[description=$description, episodes=${episodes.toString()}, title=$title, url=$url]';
  }
}
