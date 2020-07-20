import 'package:jaguar_retrofit/annotations/annotations.dart';
import 'package:jaguar_retrofit/jaguar_retrofit.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:jaguar_mimetype/jaguar_mimetype.dart';
import 'dart:async';

import 'package:netcastsoss_data_api/model/podcasts.dart';
import 'package:netcastsoss_data_api/model/loopback_count.dart';
import 'package:netcastsoss_data_api/model/podcasts_filter1.dart';
import 'package:netcastsoss_data_api/model/podcasts_filter.dart';
import 'package:netcastsoss_data_api/model/new_podcasts.dart';
import 'package:netcastsoss_data_api/model/podcasts_with_relations.dart';
import 'package:netcastsoss_data_api/model/podcasts_partial.dart';

part 'podcasts_controller_api.jretro.dart';

@GenApiClient()
class PodcastsControllerApi extends ApiClient with _$PodcastsControllerApiClient {
    final Route base;
    final Map<String, CodecRepo> converters;
    final Duration timeout;

    PodcastsControllerApi({this.base, this.converters, this.timeout = const Duration(minutes: 2)});

    /// 
    ///
    /// 
    @GetReq(path: "/podcasts/count")
    Future<LoopbackCount> podcastsControllerCount(
        
            @QueryParam("where") Map<String, Object> where
        ) {
        return super.podcastsControllerCount(
        
        where

        ).timeout(timeout);
    }

    /// 
    ///
    /// 
    @PostReq(path: "/podcasts")
    Future<Podcasts> podcastsControllerCreate(
            
             @AsJson() NewPodcasts newPodcasts
        ) {
        return super.podcastsControllerCreate(

        
        newPodcasts
        ).timeout(timeout);
    }

    /// 
    ///
    /// 
    @DeleteReq(path: "/podcasts/:id")
    Future<void> podcastsControllerDeleteById(
            @PathParam("id") String id
        ) {
        return super.podcastsControllerDeleteById(
        id

        ).timeout(timeout);
    }

    /// 
    ///
    /// 
    @GetReq(path: "/podcasts")
    Future<List<PodcastsWithRelations>> podcastsControllerFind(
        
            @QueryParam("filter") PodcastsFilter1 filter
        ) {
        return super.podcastsControllerFind(
        
        filter

        ).timeout(timeout);
    }

    /// 
    ///
    /// 
    @GetReq(path: "/podcasts/:id")
    Future<PodcastsWithRelations> podcastsControllerFindById(
            @PathParam("id") String id
        ,
            @QueryParam("filter") PodcastsFilter filter
        ) {
        return super.podcastsControllerFindById(
        id
        ,
        filter

        ).timeout(timeout);
    }

    /// 
    ///
    /// 
    @PutReq(path: "/podcasts/:id")
    Future<void> podcastsControllerReplaceById(
            @PathParam("id") String id
            ,
             @AsJson() Podcasts podcasts
        ) {
        return super.podcastsControllerReplaceById(
        id

        ,
        podcasts
        ).timeout(timeout);
    }

    /// 
    ///
    /// 
    @PatchReq(path: "/podcasts")
    Future<LoopbackCount> podcastsControllerUpdateAll(
        
            @QueryParam("where") Map<String, Object> where
            ,
             @AsJson() PodcastsPartial podcastsPartial
        ) {
        return super.podcastsControllerUpdateAll(
        
        where

        ,
        podcastsPartial
        ).timeout(timeout);
    }

    /// 
    ///
    /// 
    @PatchReq(path: "/podcasts/:id")
    Future<void> podcastsControllerUpdateById(
            @PathParam("id") String id
            ,
             @AsJson() PodcastsPartial podcastsPartial
        ) {
        return super.podcastsControllerUpdateById(
        id

        ,
        podcastsPartial
        ).timeout(timeout);
    }


}
