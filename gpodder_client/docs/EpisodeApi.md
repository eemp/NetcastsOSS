# swagger.api.EpisodeApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://gpodder.net*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getPodcastEpisode**](EpisodeApi.md#getPodcastEpisode) | **GET** /api/2/data/episode.json | Get data about an episode


# **getPodcastEpisode**
> Episode getPodcastEpisode(url, podcast)

Get data about an episode



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new EpisodeApi();
var url = url_example; // String | Episode url
var podcast = podcast_example; // String | Podcast url

try { 
    var result = api_instance.getPodcastEpisode(url, podcast);
    print(result);
} catch (e) {
    print("Exception when calling EpisodeApi->getPodcastEpisode: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **url** | **String**| Episode url | 
 **podcast** | **String**| Podcast url | 

### Return type

[**Episode**](Episode.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

