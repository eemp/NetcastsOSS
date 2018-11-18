# swagger.api.PodcastApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://gpodder.net*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getPodcast**](PodcastApi.md#getPodcast) | **GET** /api/2/data/podcast.json | Get data about a podcast
[**getPodcastsByTag**](PodcastApi.md#getPodcastsByTag) | **GET** /api/2/tag/{tag}/{total}.json | Get data about a podcast
[**getTopPodcasts**](PodcastApi.md#getTopPodcasts) | **GET** /toplist/{total}.json | Search for podcasts
[**searchPodcasts**](PodcastApi.md#searchPodcasts) | **GET** /search.json | Get list of top podcasts


# **getPodcast**
> Podcast getPodcast(url)

Get data about a podcast



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new PodcastApi();
var url = url_example; // String | Podcast url

try { 
    var result = api_instance.getPodcast(url);
    print(result);
} catch (e) {
    print("Exception when calling PodcastApi->getPodcast: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **url** | **String**| Podcast url | 

### Return type

[**Podcast**](Podcast.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPodcastsByTag**
> List<Podcast> getPodcastsByTag(tag, total)

Get data about a podcast



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new PodcastApi();
var tag = tag_example; // String | Podcast tag
var total = 56; // int | Number of podcasts to fetch

try { 
    var result = api_instance.getPodcastsByTag(tag, total);
    print(result);
} catch (e) {
    print("Exception when calling PodcastApi->getPodcastsByTag: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **tag** | **String**| Podcast tag | 
 **total** | **int**| Number of podcasts to fetch | 

### Return type

[**List<Podcast>**](Podcast.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getTopPodcasts**
> List<Podcast> getTopPodcasts(total, scaleLogo)

Search for podcasts



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new PodcastApi();
var total = 56; // int | Number of podcasts to fetch
var scaleLogo = 56; // int | Scaled logo percentage

try { 
    var result = api_instance.getTopPodcasts(total, scaleLogo);
    print(result);
} catch (e) {
    print("Exception when calling PodcastApi->getTopPodcasts: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **total** | **int**| Number of podcasts to fetch | 
 **scaleLogo** | **int**| Scaled logo percentage | [optional] 

### Return type

[**List<Podcast>**](Podcast.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchPodcasts**
> List<Podcast> searchPodcasts(q, scaleLogo)

Get list of top podcasts



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new PodcastApi();
var q = q_example; // String | Search query
var scaleLogo = 56; // int | Scaled logo percentage

try { 
    var result = api_instance.searchPodcasts(q, scaleLogo);
    print(result);
} catch (e) {
    print("Exception when calling PodcastApi->searchPodcasts: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **q** | **String**| Search query | 
 **scaleLogo** | **int**| Scaled logo percentage | [optional] 

### Return type

[**List<Podcast>**](Podcast.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

