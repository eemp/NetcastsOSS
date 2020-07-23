library netcastsoss_data_api.api;

import 'package:http/http.dart' as http;
import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:jaguar_retrofit/jaguar_retrofit.dart';
import 'package:netcastsoss_data_api/auth/api_key_auth.dart';
import 'package:netcastsoss_data_api/auth/basic_auth.dart';
import 'package:netcastsoss_data_api/auth/oauth.dart';
import 'package:jaguar_mimetype/jaguar_mimetype.dart';

import 'package:netcastsoss_data_api/api/ping_controller_api.dart';
import 'package:netcastsoss_data_api/api/podcasts_controller_api.dart';

import 'package:netcastsoss_data_api/model/inline_response200.dart';
import 'package:netcastsoss_data_api/model/loopback_count.dart';
import 'package:netcastsoss_data_api/model/new_podcasts.dart';
import 'package:netcastsoss_data_api/model/ping_response.dart';
import 'package:netcastsoss_data_api/model/podcasts.dart';
import 'package:netcastsoss_data_api/model/podcasts_fields.dart';
import 'package:netcastsoss_data_api/model/podcasts_filter.dart';
import 'package:netcastsoss_data_api/model/podcasts_filter1.dart';
import 'package:netcastsoss_data_api/model/podcasts_partial.dart';
import 'package:netcastsoss_data_api/model/podcasts_with_relations.dart';



final _jsonJaguarRepo = JsonRepo()
..add(InlineResponse200Serializer())
..add(LoopbackCountSerializer())
..add(NewPodcastsSerializer())
..add(PingResponseSerializer())
..add(PodcastsSerializer())
..add(PodcastsFieldsSerializer())
..add(PodcastsFilterSerializer())
..add(PodcastsFilter1Serializer())
..add(PodcastsPartialSerializer())
..add(PodcastsWithRelationsSerializer())
;
final Map<String, CodecRepo> defaultConverters = {
    MimeTypes.json: _jsonJaguarRepo,
};



final _defaultInterceptors = [OAuthInterceptor(), BasicAuthInterceptor(), ApiKeyAuthInterceptor()];

class NetcastsossDataApi {
    List<Interceptor> interceptors;
    String basePath = "https://netcastsoss-data.herokuapp.com";
    Route _baseRoute;
    final Duration timeout;

    /**
    * Add custom global interceptors, put overrideInterceptors to true to set your interceptors only (auth interceptors will not be added)
    */
    NetcastsossDataApi({List<Interceptor> interceptors, bool overrideInterceptors = false, String baseUrl, this.timeout = const Duration(minutes: 2)}) {
        _baseRoute = Route(baseUrl ?? basePath).withClient(globalClient ?? http.Client());
        if(interceptors == null) {
            this.interceptors = _defaultInterceptors;
        }
        else if(overrideInterceptors){
            this.interceptors = interceptors;
        }
        else {
            this.interceptors = List.from(_defaultInterceptors)..addAll(interceptors);
        }

        this.interceptors.forEach((interceptor) {
            _baseRoute.before(interceptor.before);
            _baseRoute.after(interceptor.after);
        });
    }

    void setOAuthToken(String name, String token) {
        (_defaultInterceptors[0] as OAuthInterceptor).tokens[name] = token;
    }

    void setBasicAuth(String name, String username, String password) {
        (_defaultInterceptors[1] as BasicAuthInterceptor).authInfo[name] = BasicAuthInfo(username, password);
    }

    void setApiKey(String name, String apiKey) {
        (_defaultInterceptors[2] as ApiKeyAuthInterceptor).apiKeys[name] = apiKey;
    }

    
    /**
    * Get PingControllerApi instance, base route and serializer can be overridden by a given but be careful,
    * by doing that all interceptors will not be executed
    */
    PingControllerApi getPingControllerApi({Route base, Map<String, CodecRepo> converters}) {
        if(base == null) {
            base = _baseRoute;
        }
        if(converters == null) {
            converters = defaultConverters;
        }
        return PingControllerApi(base: base, converters: converters, timeout: timeout);
    }

    
    /**
    * Get PodcastsControllerApi instance, base route and serializer can be overridden by a given but be careful,
    * by doing that all interceptors will not be executed
    */
    PodcastsControllerApi getPodcastsControllerApi({Route base, Map<String, CodecRepo> converters}) {
        if(base == null) {
            base = _baseRoute;
        }
        if(converters == null) {
            converters = defaultConverters;
        }
        return PodcastsControllerApi(base: base, converters: converters, timeout: timeout);
    }

    
}
