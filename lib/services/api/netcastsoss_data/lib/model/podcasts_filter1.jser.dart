// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcasts_filter1.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$PodcastsFilter1Serializer
    implements Serializer<PodcastsFilter1> {
  Serializer<PodcastsFields> __podcastsFieldsSerializer;
  Serializer<PodcastsFields> get _podcastsFieldsSerializer =>
      __podcastsFieldsSerializer ??= PodcastsFieldsSerializer();
  @override
  Map<String, dynamic> toMap(PodcastsFilter1 model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValueIfNotNull(ret, 'offset', model.offset);
    setMapValueIfNotNull(ret, 'limit', model.limit);
    setMapValueIfNotNull(ret, 'skip', model.skip);
    setMapValueIfNotNull(ret, 'order',
        codeNonNullIterable(model.order, (val) => val as String, []));
    setMapValueIfNotNull(
        ret,
        'where',
        codeNonNullMap(model.where, (val) => passProcessor.serialize(val),
            <String, dynamic>{}));
    setMapValueIfNotNull(
        ret, 'fields', _podcastsFieldsSerializer.toMap(model.fields));
    return ret;
  }

  @override
  PodcastsFilter1 fromMap(Map map) {
    if (map == null) return null;
    final obj = PodcastsFilter1(
        offset: map['offset'] as int ?? getJserDefault('offset'),
        limit: map['limit'] as int ?? getJserDefault('limit'),
        skip: map['skip'] as int ?? getJserDefault('skip'),
        order: codeNonNullIterable<String>(
                map['order'] as Iterable, (val) => val as String, <String>[]) ??
            getJserDefault('order'),
        where: codeNonNullMap<Object>(
                map['where'] as Map,
                (val) => passProcessor.deserialize(val) as Object,
                <String, Object>{}) ??
            getJserDefault('where'),
        fields: _podcastsFieldsSerializer.fromMap(map['fields'] as Map) ??
            getJserDefault('fields'));
    return obj;
  }
}
