# IpgeolocationSdk::TimezoneApi

All URIs are relative to *https://api.ipgeolocation.io/v2*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**get_timezone_info**](TimezoneApi.md#get_timezone_info) | **GET** /timezone | Timezone information details |


## get_timezone_info

> <TimeZoneDetailedResponse> get_timezone_info(opts)

Timezone information details

The Time Zone API provides current time, date, and time zone-related information. It supports various input types including time zone name, geographic coordinates, addresses, IPs, and location codes.  The API determines the time zone based on the following priority order if multiple parameters are provided:   1. Time Zone Name   2. Geographic Coordinates (latitude & longitude)   3. Location Address   4. IP Address   5. IATA Code   6. ICAO Code   7. UN/LOCODE  Enriched response data is returned based on the type of input: - IP: includes geolocation info - Address: includes location metadata - IATA/ICAO: includes airport info - UN/LOCODE: includes city details  You can call the time zone API without passing any time zone, coordinates, IATA, ICAO, LO code or IP address as well. It will use the calling machine's IP address to return the regional time zone information. 

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

api_instance = IpgeolocationSdk::TimezoneApi.new
opts = {
  tz: 'America/Los_Angeles', # String | pass a valid time zone name as a query parameter tz to get the time zone information.
  location: 'London, UK', # String | pass any address of a location as the query parameter location to get the time zone information.
  lat: -27.4748, # Float | pass the latitude of a location as query parameters to get the time zone information.
  long: 153.017, # Float | pass the longitude of a location as query parameters to get the time zone information.
  ip: '1.1.1.1', # String | You can pass any IPv4 or IPv6 address as a query parameter ip to get the regional timezone information.
  iata_code: 'DXB', # String | pass any 3 letter IATA code as a query paramter iata_code to get the comprehensive airport details along with the time zone information, in which that airport exists.
  icao_code: 'KATL', # String | pass any 4 letter ICAO code as a query paramter icao_code to get the comprehensive airport details along with the time zone information, in which that airport exists.
  lo_code: 'DEBER', # String | pass any 5 letter UNLOCODE as a query paramter lo_code to get the comprehensive lo code/city details along with the time zone information of the concerned city.
  output: 'json', # String | Desired output format (json or xml).
  lang: 'en' # String | By default, the API responds in English. You can change the response language by passing the language code as a query parameter `lang`. Multi language feature is available only for `paid users`.
}

begin
  # Timezone information details
  result = api_instance.get_timezone_info(opts)
  p result
rescue IpgeolocationSdk::ApiError => e
  puts "Error when calling TimezoneApi->get_timezone_info: #{e}"
end
```

#### Using the get_timezone_info_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<TimeZoneDetailedResponse>, Integer, Hash)> get_timezone_info_with_http_info(opts)

```ruby
begin
  # Timezone information details
  data, status_code, headers = api_instance.get_timezone_info_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <TimeZoneDetailedResponse>
rescue IpgeolocationSdk::ApiError => e
  puts "Error when calling TimezoneApi->get_timezone_info_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **tz** | **String** | pass a valid time zone name as a query parameter tz to get the time zone information. | [optional] |
| **location** | **String** | pass any address of a location as the query parameter location to get the time zone information. | [optional] |
| **lat** | **Float** | pass the latitude of a location as query parameters to get the time zone information. | [optional] |
| **long** | **Float** | pass the longitude of a location as query parameters to get the time zone information. | [optional] |
| **ip** | **String** | You can pass any IPv4 or IPv6 address as a query parameter ip to get the regional timezone information. | [optional] |
| **iata_code** | **String** | pass any 3 letter IATA code as a query paramter iata_code to get the comprehensive airport details along with the time zone information, in which that airport exists. | [optional] |
| **icao_code** | **String** | pass any 4 letter ICAO code as a query paramter icao_code to get the comprehensive airport details along with the time zone information, in which that airport exists. | [optional] |
| **lo_code** | **String** | pass any 5 letter UNLOCODE as a query paramter lo_code to get the comprehensive lo code/city details along with the time zone information of the concerned city. | [optional] |
| **output** | **String** | Desired output format (json or xml). | [optional] |
| **lang** | **String** | By default, the API responds in English. You can change the response language by passing the language code as a query parameter &#x60;lang&#x60;. Multi language feature is available only for &#x60;paid users&#x60;. | [optional] |

### Return type

[**TimeZoneDetailedResponse**](TimeZoneDetailedResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json, application/xml

