// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ping_response.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$PingResponseSerializer implements Serializer<PingResponse> {
  @override
  Map<String, dynamic> toMap(PingResponse model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValueIfNotNull(ret, 'greeting', model.greeting);
    setMapValueIfNotNull(ret, 'date', model.date);
    setMapValueIfNotNull(ret, 'url', model.url);
    setMapValueIfNotNull(
        ret,
        'headers',
        codeNonNullMap(model.headers, (val) => passProcessor.serialize(val),
            <String, dynamic>{}));
    return ret;
  }

  @override
  PingResponse fromMap(Map map) {
    if (map == null) return null;
    final obj = PingResponse(
        greeting: map['greeting'] as String ?? getJserDefault('greeting'),
        date: map['date'] as String ?? getJserDefault('date'),
        url: map['url'] as String ?? getJserDefault('url'),
        headers: codeNonNullMap<Object>(
                map['headers'] as Map,
                (val) => passProcessor.deserialize(val) as Object,
                <String, Object>{}) ??
            getJserDefault('headers'));
    return obj;
  }
}
