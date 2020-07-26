import 'package:jaguar_retrofit/annotations/annotations.dart';
import 'package:jaguar_retrofit/jaguar_retrofit.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:jaguar_mimetype/jaguar_mimetype.dart';
import 'dart:async';

import 'package:netcastsoss_data_api/model/ping_response.dart';

part 'ping_controller_api.jretro.dart';

@GenApiClient()
class PingControllerApi extends ApiClient with _$PingControllerApiClient {
    final Route base;
    final Map<String, CodecRepo> converters;
    final Duration timeout;

    PingControllerApi({this.base, this.converters, this.timeout = const Duration(minutes: 2)});

    /// 
    ///
    /// 
    @GetReq(path: "/ping")
    Future<PingResponse> pingControllerPing(
        ) {
        return super.pingControllerPing(

        ).timeout(timeout);
    }


}
