# IpgeolocationSdk::TimeConversionApi

All URIs are relative to *https://api.ipgeolocation.io/v2*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**convert_time_between_timezones**](TimeConversionApi.md#convert_time_between_timezones) | **GET** /timezone/convert |  |


## convert_time_between_timezones

> <TimeConversionResponse> convert_time_between_timezones(opts)



You can convert a timestamp provided as a query paramter time from one time zone to another time zone.

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

api_instance = IpgeolocationSdk::TimeConversionApi.new
opts = {
  time: '2025-02-28 9:00:00', # String | time parameter takes the input in the following two formats: i) 'yyyy-MM-dd HH:mm', and ii) 'yyyy-MM-dd HH:mm:ss'. This parameter is optional and you can omit it to convert the current time between two coordinates, time zones or locations.
  tz_from: 'America/Argentina/Catamarca', # String | timezone to convert from
  tz_to: 'Asia/Kabul', # String | timezone to convert to
  lat_from: 34.0207305, # Float | latitude to convert from
  long_from: -118.691916, # Float | longitude to convert from
  lat_to: 53.473682, # Float | latitude to convert to
  long_to: -77.397706, # Float | longitude to convert to
  location_from: 'New York, USA', # String | location to convert from
  location_to: 'Lahore, Pakistan', # String | location to convert to
  icao_from: 'YSSY', # String | location to convert from
  icao_to: 'ZBAA', # String | location to convert to
  iata_from: 'DXB', # String | location to convert from
  iata_to: 'LHR', # String | location to convert to
  locode_from: 'PKISB', # String | location to convert from
  locode_to: 'USNYC' # String | location to convert to
}

begin
  
  result = api_instance.convert_time_between_timezones(opts)
  p result
rescue IpgeolocationSdk::ApiError => e
  puts "Error when calling TimeConversionApi->convert_time_between_timezones: #{e}"
end
```

#### Using the convert_time_between_timezones_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<TimeConversionResponse>, Integer, Hash)> convert_time_between_timezones_with_http_info(opts)

```ruby
begin
  
  data, status_code, headers = api_instance.convert_time_between_timezones_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <TimeConversionResponse>
rescue IpgeolocationSdk::ApiError => e
  puts "Error when calling TimeConversionApi->convert_time_between_timezones_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **time** | **String** | time parameter takes the input in the following two formats: i) &#39;yyyy-MM-dd HH:mm&#39;, and ii) &#39;yyyy-MM-dd HH:mm:ss&#39;. This parameter is optional and you can omit it to convert the current time between two coordinates, time zones or locations. | [optional] |
| **tz_from** | **String** | timezone to convert from | [optional] |
| **tz_to** | **String** | timezone to convert to | [optional] |
| **lat_from** | **Float** | latitude to convert from | [optional] |
| **long_from** | **Float** | longitude to convert from | [optional] |
| **lat_to** | **Float** | latitude to convert to | [optional] |
| **long_to** | **Float** | longitude to convert to | [optional] |
| **location_from** | **String** | location to convert from | [optional] |
| **location_to** | **String** | location to convert to | [optional] |
| **icao_from** | **String** | location to convert from | [optional] |
| **icao_to** | **String** | location to convert to | [optional] |
| **iata_from** | **String** | location to convert from | [optional] |
| **iata_to** | **String** | location to convert to | [optional] |
| **locode_from** | **String** | location to convert from | [optional] |
| **locode_to** | **String** | location to convert to | [optional] |

### Return type

[**TimeConversionResponse**](TimeConversionResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json, application/xml

