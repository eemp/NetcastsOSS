// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ping_controller_api.dart';

// **************************************************************************
// JaguarHttpGenerator
// **************************************************************************

abstract class _$PingControllerApiClient implements ApiClient {
  final String basePath = "";
  Future<PingResponse> pingControllerPing() async {
    var req = base.get.path(basePath).path("/ping");
    return req.go(throwOnErr: true).map(decodeOne);
  }
}
