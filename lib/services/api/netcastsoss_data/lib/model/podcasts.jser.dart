// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcasts.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$PodcastsSerializer implements Serializer<Podcasts> {
  @override
  Map<String, dynamic> toMap(Podcasts model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValueIfNotNull(ret, 'id', model.id);
    setMapValueIfNotNull(ret, 'artist', model.artist);
    setMapValueIfNotNull(ret, 'artwork100', model.artwork100);
    setMapValueIfNotNull(ret, 'artwork30', model.artwork30);
    setMapValueIfNotNull(ret, 'artwork600', model.artwork600);
    setMapValueIfNotNull(ret, 'artwork60', model.artwork60);
    setMapValueIfNotNull(ret, 'artworkOrig', model.artworkOrig);
    setMapValueIfNotNull(ret, 'description', model.description);
    setMapValueIfNotNull(ret, 'episodes', model.episodes);
    setMapValueIfNotNull(ret, 'feed', model.feed);
    setMapValueIfNotNull(ret, 'genres', model.genres);
    setMapValueIfNotNull(ret, 'lastModifiedTimestamp',
        dateTimeUtcProcessor.serialize(model.lastModifiedTimestamp));
    setMapValueIfNotNull(
        ret, 'lastUpdated', dateTimeUtcProcessor.serialize(model.lastUpdated));
    setMapValueIfNotNull(ret, 'name', model.name);
    setMapValueIfNotNull(ret, 'popularity', model.popularity);
    setMapValueIfNotNull(ret, 'primaryGenre', model.primaryGenre);
    setMapValueIfNotNull(
        ret, 'releaseDate', dateTimeUtcProcessor.serialize(model.releaseDate));
    setMapValueIfNotNull(ret, 'type', model.type);
    return ret;
  }

  @override
  Podcasts fromMap(Map map) {
    if (map == null) return null;
    final obj = Podcasts(
        id: map['id'] as String ?? getJserDefault('id'),
        artist: map['artist'] as String ?? getJserDefault('artist'),
        artwork100: map['artwork100'] as String ?? getJserDefault('artwork100'),
        artwork30: map['artwork30'] as String ?? getJserDefault('artwork30'),
        artwork600: map['artwork600'] as String ?? getJserDefault('artwork600'),
        artwork60: map['artwork60'] as String ?? getJserDefault('artwork60'),
        artworkOrig:
            map['artworkOrig'] as String ?? getJserDefault('artworkOrig'),
        description:
            map['description'] as String ?? getJserDefault('description'),
        episodes: map['episodes'] as String ?? getJserDefault('episodes'),
        feed: map['feed'] as String ?? getJserDefault('feed'),
        genres: map['genres'] as String ?? getJserDefault('genres'),
        lastModifiedTimestamp: dateTimeUtcProcessor
                .deserialize(map['lastModifiedTimestamp'] as String) ??
            getJserDefault('lastModifiedTimestamp'),
        lastUpdated:
            dateTimeUtcProcessor.deserialize(map['lastUpdated'] as String) ??
                getJserDefault('lastUpdated'),
        name: map['name'] as String ?? getJserDefault('name'),
        popularity: map['popularity'] as num ?? getJserDefault('popularity'),
        primaryGenre:
            map['primaryGenre'] as String ?? getJserDefault('primaryGenre'),
        releaseDate:
            dateTimeUtcProcessor.deserialize(map['releaseDate'] as String) ??
                getJserDefault('releaseDate'),
        type: map['type'] as String ?? getJserDefault('type'));
    return obj;
  }
}
