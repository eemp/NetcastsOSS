# netcastsoss_data_api.api.PodcastsControllerApi

## Load the API package
```dart
import 'package:netcastsoss_data_api/api.dart';
```

All URIs are relative to *https://netcastsoss-data.herokuapp.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**podcastsControllerCount**](PodcastsControllerApi.md#podcastsControllerCount) | **Get** /podcasts/count | 
[**podcastsControllerCreate**](PodcastsControllerApi.md#podcastsControllerCreate) | **Post** /podcasts | 
[**podcastsControllerDeleteById**](PodcastsControllerApi.md#podcastsControllerDeleteById) | **Delete** /podcasts/:id | 
[**podcastsControllerFind**](PodcastsControllerApi.md#podcastsControllerFind) | **Get** /podcasts | 
[**podcastsControllerFindById**](PodcastsControllerApi.md#podcastsControllerFindById) | **Get** /podcasts/:id | 
[**podcastsControllerReplaceById**](PodcastsControllerApi.md#podcastsControllerReplaceById) | **Put** /podcasts/:id | 
[**podcastsControllerUpdateAll**](PodcastsControllerApi.md#podcastsControllerUpdateAll) | **Patch** /podcasts | 
[**podcastsControllerUpdateById**](PodcastsControllerApi.md#podcastsControllerUpdateById) | **Patch** /podcasts/:id | 


# **podcastsControllerCount**
> LoopbackCount podcastsControllerCount(where)



### Example 
```dart
import 'package:netcastsoss_data_api/api.dart';

var api_instance = new PodcastsControllerApi();
var where = Object; // Map<String, Object> | 

try { 
    var result = api_instance.podcastsControllerCount(where);
    print(result);
} catch (e) {
    print("Exception when calling PodcastsControllerApi->podcastsControllerCount: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **where** | [**Map&lt;String, Object&gt;**](Object.md)|  | [optional] [default to const {}]

### Return type

[**LoopbackCount**](LoopbackCount.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **podcastsControllerCreate**
> Podcasts podcastsControllerCreate(newPodcasts)



### Example 
```dart
import 'package:netcastsoss_data_api/api.dart';

var api_instance = new PodcastsControllerApi();
var newPodcasts = new NewPodcasts(); // NewPodcasts | 

try { 
    var result = api_instance.podcastsControllerCreate(newPodcasts);
    print(result);
} catch (e) {
    print("Exception when calling PodcastsControllerApi->podcastsControllerCreate: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **newPodcasts** | [**NewPodcasts**](NewPodcasts.md)|  | [optional] 

### Return type

[**Podcasts**](Podcasts.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **podcastsControllerDeleteById**
> podcastsControllerDeleteById(id)



### Example 
```dart
import 'package:netcastsoss_data_api/api.dart';

var api_instance = new PodcastsControllerApi();
var id = id_example; // String | 

try { 
    api_instance.podcastsControllerDeleteById(id);
} catch (e) {
    print("Exception when calling PodcastsControllerApi->podcastsControllerDeleteById: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | [default to null]

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **podcastsControllerFind**
> List<PodcastsWithRelations> podcastsControllerFind(filter)



### Example 
```dart
import 'package:netcastsoss_data_api/api.dart';

var api_instance = new PodcastsControllerApi();
var filter = ; // PodcastsFilter1 | 

try { 
    var result = api_instance.podcastsControllerFind(filter);
    print(result);
} catch (e) {
    print("Exception when calling PodcastsControllerApi->podcastsControllerFind: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **filter** | [**PodcastsFilter1**](.md)|  | [optional] [default to null]

### Return type

[**List<PodcastsWithRelations>**](PodcastsWithRelations.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **podcastsControllerFindById**
> PodcastsWithRelations podcastsControllerFindById(id, filter)



### Example 
```dart
import 'package:netcastsoss_data_api/api.dart';

var api_instance = new PodcastsControllerApi();
var id = id_example; // String | 
var filter = ; // PodcastsFilter | 

try { 
    var result = api_instance.podcastsControllerFindById(id, filter);
    print(result);
} catch (e) {
    print("Exception when calling PodcastsControllerApi->podcastsControllerFindById: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | [default to null]
 **filter** | [**PodcastsFilter**](.md)|  | [optional] [default to null]

### Return type

[**PodcastsWithRelations**](PodcastsWithRelations.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **podcastsControllerReplaceById**
> podcastsControllerReplaceById(id, podcasts)



### Example 
```dart
import 'package:netcastsoss_data_api/api.dart';

var api_instance = new PodcastsControllerApi();
var id = id_example; // String | 
var podcasts = new Podcasts(); // Podcasts | 

try { 
    api_instance.podcastsControllerReplaceById(id, podcasts);
} catch (e) {
    print("Exception when calling PodcastsControllerApi->podcastsControllerReplaceById: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | [default to null]
 **podcasts** | [**Podcasts**](Podcasts.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **podcastsControllerUpdateAll**
> LoopbackCount podcastsControllerUpdateAll(where, podcastsPartial)



### Example 
```dart
import 'package:netcastsoss_data_api/api.dart';

var api_instance = new PodcastsControllerApi();
var where = Object; // Map<String, Object> | 
var podcastsPartial = new PodcastsPartial(); // PodcastsPartial | 

try { 
    var result = api_instance.podcastsControllerUpdateAll(where, podcastsPartial);
    print(result);
} catch (e) {
    print("Exception when calling PodcastsControllerApi->podcastsControllerUpdateAll: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **where** | [**Map&lt;String, Object&gt;**](Object.md)|  | [optional] [default to const {}]
 **podcastsPartial** | [**PodcastsPartial**](PodcastsPartial.md)|  | [optional] 

### Return type

[**LoopbackCount**](LoopbackCount.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **podcastsControllerUpdateById**
> podcastsControllerUpdateById(id, podcastsPartial)



### Example 
```dart
import 'package:netcastsoss_data_api/api.dart';

var api_instance = new PodcastsControllerApi();
var id = id_example; // String | 
var podcastsPartial = new PodcastsPartial(); // PodcastsPartial | 

try { 
    api_instance.podcastsControllerUpdateById(id, podcastsPartial);
} catch (e) {
    print("Exception when calling PodcastsControllerApi->podcastsControllerUpdateById: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | [default to null]
 **podcastsPartial** | [**PodcastsPartial**](PodcastsPartial.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

