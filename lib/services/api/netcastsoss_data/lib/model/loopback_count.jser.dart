// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loopback_count.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$LoopbackCountSerializer implements Serializer<LoopbackCount> {
  @override
  Map<String, dynamic> toMap(LoopbackCount model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValueIfNotNull(ret, 'count', model.count);
    return ret;
  }

  @override
  LoopbackCount fromMap(Map map) {
    if (map == null) return null;
    final obj =
        LoopbackCount(count: map['count'] as num ?? getJserDefault('count'));
    return obj;
  }
}
