// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inline_response200.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$InlineResponse200Serializer
    implements Serializer<InlineResponse200> {
  Serializer<PodcastsWithRelations> __podcastsWithRelationsSerializer;
  Serializer<PodcastsWithRelations> get _podcastsWithRelationsSerializer =>
      __podcastsWithRelationsSerializer ??= PodcastsWithRelationsSerializer();
  @override
  Map<String, dynamic> toMap(InlineResponse200 model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValueIfNotNull(ret, 'genre', model.genre);
    setMapValueIfNotNull(
        ret,
        'items',
        codeNonNullIterable(
            model.items,
            (val) => _podcastsWithRelationsSerializer
                .toMap(val as PodcastsWithRelations),
            []));
    return ret;
  }

  @override
  InlineResponse200 fromMap(Map map) {
    if (map == null) return null;
    final obj = InlineResponse200(
        genre: map['genre'] as String ?? getJserDefault('genre'),
        items: codeNonNullIterable<PodcastsWithRelations>(
                map['items'] as Iterable,
                (val) => _podcastsWithRelationsSerializer.fromMap(val as Map),
                <PodcastsWithRelations>[]) ??
            getJserDefault('items'));
    return obj;
  }
}
