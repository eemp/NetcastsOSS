# netcastsoss_data_api.api.PingControllerApi

## Load the API package
```dart
import 'package:netcastsoss_data_api/api.dart';
```

All URIs are relative to *https://netcastsoss-data.herokuapp.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**pingControllerPing**](PingControllerApi.md#pingControllerPing) | **Get** /ping | 


# **pingControllerPing**
> PingResponse pingControllerPing()



### Example 
```dart
import 'package:netcastsoss_data_api/api.dart';

var api_instance = new PingControllerApi();

try { 
    var result = api_instance.pingControllerPing();
    print(result);
} catch (e) {
    print("Exception when calling PingControllerApi->pingControllerPing: $e\n");
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**PingResponse**](PingResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

