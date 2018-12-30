part of swagger.api;



class EpisodeApi {
  final ApiClient apiClient;

  EpisodeApi([ApiClient apiClient]) : apiClient = apiClient ?? defaultApiClient;

  /// Get data about an episode
  ///
  /// 
  Future<Episode> getPodcastEpisode(String url, String podcast) async {
    Object postBody = null;

    // verify required params are set
    if(url == null) {
     throw new ApiException(400, "Missing required param: url");
    }
    if(podcast == null) {
     throw new ApiException(400, "Missing required param: podcast");
    }

    // create path and map variables
    String path = "/api/2/data/episode.json".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
      queryParams.addAll(_convertParametersForCollectionFormat("", "url", url));
      queryParams.addAll(_convertParametersForCollectionFormat("", "podcast", podcast));
    
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
          apiClient.deserialize(response.body, 'Episode') as Episode ;
    } else {
      return null;
    }
  }
}
