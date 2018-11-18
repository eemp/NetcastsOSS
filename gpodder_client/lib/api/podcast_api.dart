part of swagger.api;



class PodcastApi {
  final ApiClient apiClient;

  PodcastApi([ApiClient apiClient]) : apiClient = apiClient ?? defaultApiClient;

  /// Get data about a podcast
  ///
  /// 
  Future<Podcast> getPodcast(String url) async {
    Object postBody = null;

    // verify required params are set
    if(url == null) {
     throw new ApiException(400, "Missing required param: url");
    }

    // create path and map variables
    String path = "/api/2/data/podcast.json".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
      queryParams.addAll(_convertParametersForCollectionFormat("", "url", url));
    
    List<String> contentTypes = [];

    String contentType = contentTypes.length > 0 ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = new MultipartRequest(null, null);
      
      if(hasFields)
        postBody = mp;
    }
    else {
          }

    var response = await apiClient.invokeAPI(path,
                                             'GET',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);

    if(response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if(response.body != null) {
      return 
          apiClient.deserialize(response.body, 'Podcast') as Podcast ;
    } else {
      return null;
    }
  }
  /// Get data about a podcast
  ///
  /// 
  Future<List<Podcast>> getPodcastsByTag(String tag, int total) async {
    Object postBody = null;

    // verify required params are set
    if(tag == null) {
     throw new ApiException(400, "Missing required param: tag");
    }
    if(total == null) {
     throw new ApiException(400, "Missing required param: total");
    }

    // create path and map variables
    String path = "/api/2/tag/{tag}/{total}.json".replaceAll("{format}","json").replaceAll("{" + "tag" + "}", tag.toString()).replaceAll("{" + "total" + "}", total.toString());

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    
    List<String> contentTypes = [];

    String contentType = contentTypes.length > 0 ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = new MultipartRequest(null, null);
      
      if(hasFields)
        postBody = mp;
    }
    else {
          }

    var response = await apiClient.invokeAPI(path,
                                             'GET',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);

    if(response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if(response.body != null) {
      return 
        (apiClient.deserialize(response.body, 'List<Podcast>') as List).map((item) => item as Podcast).toList();
    } else {
      return null;
    }
  }
  /// Search for podcasts
  ///
  /// 
  Future<List<Podcast>> getTopPodcasts(int total, { int scaleLogo }) async {
    Object postBody = null;

    // verify required params are set
    if(total == null) {
     throw new ApiException(400, "Missing required param: total");
    }

    // create path and map variables
    String path = "/toplist/{total}.json".replaceAll("{format}","json").replaceAll("{" + "total" + "}", total.toString());

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    if(scaleLogo != null) {
      queryParams.addAll(_convertParametersForCollectionFormat("", "scale_logo", scaleLogo));
    }
    
    List<String> contentTypes = [];

    String contentType = contentTypes.length > 0 ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = new MultipartRequest(null, null);
      
      if(hasFields)
        postBody = mp;
    }
    else {
          }

    var response = await apiClient.invokeAPI(path,
                                             'GET',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);

    if(response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if(response.body != null) {
      return 
        (apiClient.deserialize(response.body, 'List<Podcast>') as List).map((item) => item as Podcast).toList();
    } else {
      return null;
    }
  }
  /// Get list of top podcasts
  ///
  /// 
  Future<List<Podcast>> searchPodcasts(String q, { int scaleLogo }) async {
    Object postBody = null;

    // verify required params are set
    if(q == null) {
     throw new ApiException(400, "Missing required param: q");
    }

    // create path and map variables
    String path = "/search.json".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
      queryParams.addAll(_convertParametersForCollectionFormat("", "q", q));
    if(scaleLogo != null) {
      queryParams.addAll(_convertParametersForCollectionFormat("", "scale_logo", scaleLogo));
    }
    
    List<String> contentTypes = [];

    String contentType = contentTypes.length > 0 ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = new MultipartRequest(null, null);
      
      if(hasFields)
        postBody = mp;
    }
    else {
          }

    var response = await apiClient.invokeAPI(path,
                                             'GET',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);

    if(response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if(response.body != null) {
      return 
        (apiClient.deserialize(response.body, 'List<Podcast>') as List).map((item) => item as Podcast).toList();
    } else {
      return null;
    }
  }
}
