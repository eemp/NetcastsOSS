# swagger.api.EpisdoeApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://gpodder.net*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getPodcastEpisode**](EpisdoeApi.md#getPodcastEpisode) | **GET** /api/2/data/episode.json | Get data about an episode


# **getPodcastEpisode**
> Episode getPodcastEpisode(episodeUrl, podcastUrl)

Get data about an episode



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new EpisdoeApi();
var episodeUrl = episodeUrl_example; // String | Episode url
var podcastUrl = podcastUrl_example; // String | Podcast url

try { 
    var result = api_instance.getPodcastEpisode(episodeUrl, podcastUrl);
    print(result);
} catch (e) {
    print("Exception when calling EpisdoeApi->getPodcastEpisode: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **episodeUrl** | **String**| Episode url | 
 **podcastUrl** | **String**| Podcast url | 

### Return type

[**Episode**](Episode.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

