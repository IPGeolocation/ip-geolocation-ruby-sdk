# IpgeolocationSdk::AstronomyApi

All URIs are relative to *https://api.ipgeolocation.io/v2*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**get_astronomy_details**](AstronomyApi.md#get_astronomy_details) | **GET** /astronomy |  |


## get_astronomy_details

> <AstronomyResponse> get_astronomy_details(opts)



The Astronomy API provides the location-based rise and set times for the Sun and Moon along with the current position, distance from earth, and azimuth of the Sun and the Moon for a specific date at the queried time. 

### Examples

```ruby
require 'time'
require 'ipgeolocation_sdk'
# setup authorization
IpgeolocationSdk.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['apiKey'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  # config.api_key_prefix['apiKey'] = 'Bearer'
end

api_instance = IpgeolocationSdk::AstronomyApi.new
opts = {
  ip: '8.8.8.8', # String | query paramter 'ip'. If not provided, will be your network IP
  location: 'New York, US', # String | query paramter 'location'. If not provided, will be your ip location
  lat: '40.76473', # String | query paramter 'lat'.
  long: '-74.00084', # String | query paramter 'long'.
  time_zone: 'Europe/London', # String | 
  date: '2025-04-22', # String | The date (YYYY-MM-DD) to lookup for. default will be the current date
  elevation: 9, # Float | query parameter 'elevation'
  output: 'json', # String | Desired output format.
  lang: 'en' # String | By default, the API responds in English. You can change the response language by passing the language code as a query parameter `lang`. Multi language feature is available only for `paid users`.
}

begin
  
  result = api_instance.get_astronomy_details(opts)
  p result
rescue IpgeolocationSdk::ApiError => e
  puts "Error when calling AstronomyApi->get_astronomy_details: #{e}"
end
```

#### Using the get_astronomy_details_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<AstronomyResponse>, Integer, Hash)> get_astronomy_details_with_http_info(opts)

```ruby
begin
  
  data, status_code, headers = api_instance.get_astronomy_details_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <AstronomyResponse>
rescue IpgeolocationSdk::ApiError => e
  puts "Error when calling AstronomyApi->get_astronomy_details_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **ip** | **String** | query paramter &#39;ip&#39;. If not provided, will be your network IP | [optional] |
| **location** | **String** | query paramter &#39;location&#39;. If not provided, will be your ip location | [optional] |
| **lat** | **String** | query paramter &#39;lat&#39;. | [optional] |
| **long** | **String** | query paramter &#39;long&#39;. | [optional] |
| **time_zone** | **String** |  | [optional] |
| **date** | **String** | The date (YYYY-MM-DD) to lookup for. default will be the current date | [optional] |
| **elevation** | **Float** | query parameter &#39;elevation&#39; | [optional] |
| **output** | **String** | Desired output format. | [optional] |
| **lang** | **String** | By default, the API responds in English. You can change the response language by passing the language code as a query parameter &#x60;lang&#x60;. Multi language feature is available only for &#x60;paid users&#x60;. | [optional] |

### Return type

[**AstronomyResponse**](AstronomyResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json, application/xml

