// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcasts_controller_api.dart';

// **************************************************************************
// JaguarHttpGenerator
// **************************************************************************

abstract class _$PodcastsControllerApiClient implements ApiClient {
  final String basePath = "";
  Future<LoopbackCount> podcastsControllerCount(
      Map<String, Object> where) async {
    var req =
        base.get.path(basePath).path("/podcasts/count").query("where", where);
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<Podcasts> podcastsControllerCreate(NewPodcasts newPodcasts) async {
    var req = base.post
        .path(basePath)
        .path("/podcasts")
        .json(jsonConverter.to(newPodcasts));
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<void> podcastsControllerDeleteById(String id) async {
    var req =
        base.delete.path(basePath).path("/podcasts/:id").pathParams("id", id);
    await req.go(throwOnErr: true);
  }

  Future<List<PodcastsWithRelations>> podcastsControllerFind(
      PodcastsFilter filter) async {
    var req = base.get.path(basePath).path("/podcasts").query("filter", filter);
    return req.go(throwOnErr: true).map(decodeList);
  }

  Future<PodcastsWithRelations> podcastsControllerFindById(
      String id, PodcastsFilter1 filter) async {
    var req = base.get
        .path(basePath)
        .path("/podcasts/:id")
        .pathParams("id", id)
        .query("filter", filter);
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<List<InlineResponse200>> podcastsControllerFindPopularPodcasts(
      PodcastsFilter filter) async {
    var req = base.get
        .path(basePath)
        .path("/podcasts/popular-by-genre")
        .query("filter", filter);
    return req.go(throwOnErr: true).map(decodeList);
  }

  Future<void> podcastsControllerReplaceById(
      String id, Podcasts podcasts) async {
    var req = base.put
        .path(basePath)
        .path("/podcasts/:id")
        .pathParams("id", id)
        .json(jsonConverter.to(podcasts));
    await req.go(throwOnErr: true);
  }

  Future<List<PodcastsWithRelations>> podcastsControllerSearchPodcastsByText(
      String q, PodcastsFilter filter) async {
    var req = base.get
        .path(basePath)
        .path("/podcasts/text-search")
        .query("q", q)
        .query("filter", filter);
    return req.go(throwOnErr: true).map(decodeList);
  }

  Future<LoopbackCount> podcastsControllerUpdateAll(
      Map<String, Object> where, PodcastsPartial podcastsPartial) async {
    var req = base.patch
        .path(basePath)
        .path("/podcasts")
        .query("where", where)
        .json(jsonConverter.to(podcastsPartial));
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<void> podcastsControllerUpdateById(
      String id, PodcastsPartial podcastsPartial) async {
    var req = base.patch
        .path(basePath)
        .path("/podcasts/:id")
        .pathParams("id", id)
        .json(jsonConverter.to(podcastsPartial));
    await req.go(throwOnErr: true);
  }
}
