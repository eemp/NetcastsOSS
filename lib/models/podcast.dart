import 'dart:convert';

import 'package:hear2learn/models/episode.dart';
import 'package:netcastsoss_data_api/model/podcasts_with_relations.dart';

class Artist {
  String id;
  String name;

  Artist({
    this.id,
    this.name,
  });

  Artist.fromJson(dynamic json) {
    if(json is String) {
      json = jsonDecode(json);
    }

    id = json['id'].toString();
    name = json['name'];
  }

  String toJson() {
    return jsonEncode(<String, String>{
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

  Genre.fromJson(dynamic json) {
    if(json is String) {
      json = jsonDecode(json);
    }

    id = json['id'].toString();
    name = json['name'];
  }

  String toJson() {
    return jsonEncode(<String, String>{
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
  String logoUrl; // TODO(eemp): to be deprecated, removed
  String name;
  int popularity;
  String title; // TODO(eemp): to be deprecated, removed
  DateTime releaseDate;
  String url; // TODO(eemp): to be deprecated, removed

  Podcast({
    this.artist,
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
    this.logoUrl, // TODO(eemp): to be deprecated, removed
    this.name,
    this.popularity,
    this.releaseDate,
    this.title, // todo: to be deprecated, removed
    this.url, // todo: to be deprecated, removed
  });

  Podcast.fromRemote(PodcastsWithRelations remotePodcast) {
    this.artist = Artist.fromJson(remotePodcast.artist);
    this.artwork30 = remotePodcast.artwork30;
    this.artwork60 = remotePodcast.artwork60;
    this.artwork100 = remotePodcast.artwork100;
    this.artwork600 = remotePodcast.artwork600;
    this.artworkOrig = remotePodcast.artworkOrig;
    this.description = remotePodcast.description;
    // this.episodes = ...;
    this.feed = remotePodcast.feed;
    this.id = remotePodcast.id;
    this.lastModifiedDate = remotePodcast.lastModifiedTimestamp;
    this.name = remotePodcast.name;
    this.popularity = remotePodcast.popularity;
    this.releaseDate = remotePodcast.releaseDate;
  }

  String getByline() {
    return name != artist?.name
      ? 'by ${artist?.name}, ${episodesCount.toString()} total episodes'
      : '${episodesCount.toString()} total episodes';
  }

  Podcast.fromJson(dynamic json) {
    if(json is String) {
      json = jsonDecode(json);
      json['episodes'] = jsonDecode(json['episodes']);
    }

    artist = Artist.fromJson(json['artist']);
    artwork30 = json['artwork30'];
    artwork60 = json['artwork60'];
    artwork100 = json['artwork100'];
    artwork600 = json['artwork600'];
    artworkOrig = json['artworkOrig'];
    description = json['description'];
    episodesCount = json['episodesCount'] ??
      (json['episodes'] != null ? json['episodes']['count'] : 0);
    feed = json['feed'];
    id = json['id'].toString();
    //lastModifiedDate = DateTime(json['last_modified_date']);
    name = json['name'];
    //popularity = json['popularity'];
    //releaseDate = DateTime(json['release_date']);

    final List<dynamic> rawGenres = json['genres'];
    genres = rawGenres is List
        ? rawGenres.map((dynamic genreJson) => Genre.fromJson(genreJson)).toList()
        : <Genre>[];
  }

  String toJson() {
    return jsonEncode(<String, dynamic>{
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
    return 'Podcast[id=$id, description=$description, episodes=${episodes.toString()}, feed=$feed, name=$name]';
  }
}
