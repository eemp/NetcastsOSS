// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcasts_fields.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$PodcastsFieldsSerializer
    implements Serializer<PodcastsFields> {
  @override
  Map<String, dynamic> toMap(PodcastsFields model) {
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
    setMapValueIfNotNull(
        ret, 'lastModifiedTimestamp', model.lastModifiedTimestamp);
    setMapValueIfNotNull(ret, 'lastUpdated', model.lastUpdated);
    setMapValueIfNotNull(ret, 'name', model.name);
    setMapValueIfNotNull(ret, 'popularity', model.popularity);
    setMapValueIfNotNull(ret, 'primaryGenre', model.primaryGenre);
    setMapValueIfNotNull(ret, 'releaseDate', model.releaseDate);
    setMapValueIfNotNull(ret, 'type', model.type);
    return ret;
  }

  @override
  PodcastsFields fromMap(Map map) {
    if (map == null) return null;
    final obj = PodcastsFields(
        id: map['id'] as bool ?? getJserDefault('id'),
        artist: map['artist'] as bool ?? getJserDefault('artist'),
        artwork100: map['artwork100'] as bool ?? getJserDefault('artwork100'),
        artwork30: map['artwork30'] as bool ?? getJserDefault('artwork30'),
        artwork600: map['artwork600'] as bool ?? getJserDefault('artwork600'),
        artwork60: map['artwork60'] as bool ?? getJserDefault('artwork60'),
        artworkOrig:
            map['artworkOrig'] as bool ?? getJserDefault('artworkOrig'),
        description:
            map['description'] as bool ?? getJserDefault('description'),
        episodes: map['episodes'] as bool ?? getJserDefault('episodes'),
        feed: map['feed'] as bool ?? getJserDefault('feed'),
        genres: map['genres'] as bool ?? getJserDefault('genres'),
        lastModifiedTimestamp: map['lastModifiedTimestamp'] as bool ??
            getJserDefault('lastModifiedTimestamp'),
        lastUpdated:
            map['lastUpdated'] as bool ?? getJserDefault('lastUpdated'),
        name: map['name'] as bool ?? getJserDefault('name'),
        popularity: map['popularity'] as bool ?? getJserDefault('popularity'),
        primaryGenre:
            map['primaryGenre'] as bool ?? getJserDefault('primaryGenre'),
        releaseDate:
            map['releaseDate'] as bool ?? getJserDefault('releaseDate'),
        type: map['type'] as bool ?? getJserDefault('type'));
    return obj;
  }
}
