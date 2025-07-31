# IpgeolocationSdk::IPLocationApi

All URIs are relative to *https://api.ipgeolocation.io/v2*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**get_bulk_ip_geolocation**](IPLocationApi.md#get_bulk_ip_geolocation) | **POST** /ipgeo-bulk |  |
| [**get_ip_geolocation**](IPLocationApi.md#get_ip_geolocation) | **GET** /ipgeo |  |


## get_bulk_ip_geolocation

> <Array<GetBulkIpGeolocation200ResponseInner>> get_bulk_ip_geolocation(get_bulk_ip_geolocation_request, opts)



This feature is available only on our paid API subscriptions (STANDARD or ADVANCED). This endpoint allows you to perform the geolocation lookup for multiple IPv4, IPv6 addresses or domain names (maximum 50,000) at the same time. The requests count per lookup is equal to total IP addresses or domain names passed. To perform bulk IP Geolocation Lookup, send a POST request and pass the \"ips\" array as JSON data along with it.  

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

api_instance = IpgeolocationSdk::IPLocationApi.new
get_bulk_ip_geolocation_request = IpgeolocationSdk::GetBulkIpGeolocationRequest.new # GetBulkIpGeolocationRequest | 
opts = {
  lang: 'en', # String | By default, the API responds in English. You can change the response language by passing the language code as a query parameter `lang`. Multi language feature is available only for `paid users`.
  fields: 'location, location.country_name, network.asn.organization', # String | you can filter the API response by specifying the fields that you need, instead of getting the full response. To do this, pass the desired field names using the `fields` query parameter with each field represented as a dot-separated path.
  excludes: 'location.continent_code,currency,network', # String | you can also filter the API response by excluding specific fields (except the IP address) that you don't need. To do this, pass the unwanted field names using the excludes query parameter, with each field represented as a dot-separated path
  include: 'security', # String | IP Geolocation API also provides IP-Security, abuse, timezone, user-agent and DMA (Designated Market Area) code, which is specifically used in the US for marketing and regional targeting information on Advanced API subscription, but doesn't respond it by default. To get these information along with the geolocation information, you must pass the `include=security` or `include=abuse` or `include=dma` or `include=time_zone` or `include=user-agent` or you can fetch multiples by adding values in comma-separated way. In addition to that, IPGeolocation API also provide hostname lookup for an IP address on all the paid API subscriptions (STANDARD and ADVANCED), but doesn't respond it by default. To get the hostname for an IP address, you can pass one of the three values `hostname, liveHostname, hostnameFallbackLive` as a URL parameter `include=`.
  output: 'json' # String | Desired output format(json or xml).
}

begin
  
  result = api_instance.get_bulk_ip_geolocation(get_bulk_ip_geolocation_request, opts)
  p result
rescue IpgeolocationSdk::ApiError => e
  puts "Error when calling IPLocationApi->get_bulk_ip_geolocation: #{e}"
end
```

#### Using the get_bulk_ip_geolocation_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<Array<GetBulkIpGeolocation200ResponseInner>>, Integer, Hash)> get_bulk_ip_geolocation_with_http_info(get_bulk_ip_geolocation_request, opts)

```ruby
begin
  
  data, status_code, headers = api_instance.get_bulk_ip_geolocation_with_http_info(get_bulk_ip_geolocation_request, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <Array<GetBulkIpGeolocation200ResponseInner>>
rescue IpgeolocationSdk::ApiError => e
  puts "Error when calling IPLocationApi->get_bulk_ip_geolocation_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **get_bulk_ip_geolocation_request** | [**GetBulkIpGeolocationRequest**](GetBulkIpGeolocationRequest.md) |  |  |
| **lang** | **String** | By default, the API responds in English. You can change the response language by passing the language code as a query parameter &#x60;lang&#x60;. Multi language feature is available only for &#x60;paid users&#x60;. | [optional] |
| **fields** | **String** | you can filter the API response by specifying the fields that you need, instead of getting the full response. To do this, pass the desired field names using the &#x60;fields&#x60; query parameter with each field represented as a dot-separated path. | [optional] |
| **excludes** | **String** | you can also filter the API response by excluding specific fields (except the IP address) that you don&#39;t need. To do this, pass the unwanted field names using the excludes query parameter, with each field represented as a dot-separated path | [optional] |
| **include** | **String** | IP Geolocation API also provides IP-Security, abuse, timezone, user-agent and DMA (Designated Market Area) code, which is specifically used in the US for marketing and regional targeting information on Advanced API subscription, but doesn&#39;t respond it by default. To get these information along with the geolocation information, you must pass the &#x60;include&#x3D;security&#x60; or &#x60;include&#x3D;abuse&#x60; or &#x60;include&#x3D;dma&#x60; or &#x60;include&#x3D;time_zone&#x60; or &#x60;include&#x3D;user-agent&#x60; or you can fetch multiples by adding values in comma-separated way. In addition to that, IPGeolocation API also provide hostname lookup for an IP address on all the paid API subscriptions (STANDARD and ADVANCED), but doesn&#39;t respond it by default. To get the hostname for an IP address, you can pass one of the three values &#x60;hostname, liveHostname, hostnameFallbackLive&#x60; as a URL parameter &#x60;include&#x3D;&#x60;. | [optional] |
| **output** | **String** | Desired output format(json or xml). | [optional] |

### Return type

[**Array&lt;GetBulkIpGeolocation200ResponseInner&gt;**](GetBulkIpGeolocation200ResponseInner.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json, application/xml


## get_ip_geolocation

> <GeolocationResponse> get_ip_geolocation(opts)



IP Geolocation API provides real-time and accurate geolocation, network, abuse, and security information for any IPv4 or IPv6 address and domain name along with the user-agent detail for the provided user-agent string. You can geolocate your online visitors and provide them the customized user-experience accordingly.

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

api_instance = IpgeolocationSdk::IPLocationApi.new
opts = {
  ip: '8.8.8.8 OR dns.google.com', # String | In order to find geolocation information about an IP (ipv4 ipv6) address or a domain name, pass it as a query parameter ip. When this endpoint is queried without an IP address, it returns the geolocation information of the device/client which is calling it
  lang: 'en', # String | By default, the API responds in English. You can change the response language by passing the language code as a query parameter `lang`. Multi language feature is available only for `paid users`.
  fields: 'location, location.country_name, network.asn.organization', # String | you can filter the API response by specifying the fields that you need, instead of getting the full response. To do this, pass the desired field names using the `fields` query parameter with each field represented as a dot-separated path.
  excludes: 'location.continent_code,currency,network', # String | you can also filter the API response by excluding specific fields (except the IP address) that you don't need. To do this, pass the unwanted field names using the excludes query parameter, with each field represented as a dot-separated path
  include: 'security', # String | IP Geolocation API also provides IP-Security, abuse, timezone, user-agent and DMA (Designated Market Area) code, which is specifically used in the US for marketing and regional targeting information on Advanced API subscription, but doesn't respond it by default. To get these information along with the geolocation information, you must pass the `include=security` or `include=abuse` or `include=dma` or `include=time_zone` or `include=user-agent` or you can fetch multiples by adding values in comma-separated way. In addition to that, IPGeolocation API also provide hostname lookup for an IP address on all the paid API subscriptions (STANDARD and ADVANCED), but doesn't respond it by default. To get the hostname for an IP address, you can pass one of the three values `hostname, liveHostname, hostnameFallbackLive` as a URL parameter `include=`.
  output: 'json' # String | Desired output format (json or xml).
}

begin
  
  result = api_instance.get_ip_geolocation(opts)
  p result
rescue IpgeolocationSdk::ApiError => e
  puts "Error when calling IPLocationApi->get_ip_geolocation: #{e}"
end
```

#### Using the get_ip_geolocation_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<GeolocationResponse>, Integer, Hash)> get_ip_geolocation_with_http_info(opts)

```ruby
begin
  
  data, status_code, headers = api_instance.get_ip_geolocation_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <GeolocationResponse>
rescue IpgeolocationSdk::ApiError => e
  puts "Error when calling IPLocationApi->get_ip_geolocation_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **ip** | **String** | In order to find geolocation information about an IP (ipv4 ipv6) address or a domain name, pass it as a query parameter ip. When this endpoint is queried without an IP address, it returns the geolocation information of the device/client which is calling it | [optional] |
| **lang** | **String** | By default, the API responds in English. You can change the response language by passing the language code as a query parameter &#x60;lang&#x60;. Multi language feature is available only for &#x60;paid users&#x60;. | [optional] |
| **fields** | **String** | you can filter the API response by specifying the fields that you need, instead of getting the full response. To do this, pass the desired field names using the &#x60;fields&#x60; query parameter with each field represented as a dot-separated path. | [optional] |
| **excludes** | **String** | you can also filter the API response by excluding specific fields (except the IP address) that you don&#39;t need. To do this, pass the unwanted field names using the excludes query parameter, with each field represented as a dot-separated path | [optional] |
| **include** | **String** | IP Geolocation API also provides IP-Security, abuse, timezone, user-agent and DMA (Designated Market Area) code, which is specifically used in the US for marketing and regional targeting information on Advanced API subscription, but doesn&#39;t respond it by default. To get these information along with the geolocation information, you must pass the &#x60;include&#x3D;security&#x60; or &#x60;include&#x3D;abuse&#x60; or &#x60;include&#x3D;dma&#x60; or &#x60;include&#x3D;time_zone&#x60; or &#x60;include&#x3D;user-agent&#x60; or you can fetch multiples by adding values in comma-separated way. In addition to that, IPGeolocation API also provide hostname lookup for an IP address on all the paid API subscriptions (STANDARD and ADVANCED), but doesn&#39;t respond it by default. To get the hostname for an IP address, you can pass one of the three values &#x60;hostname, liveHostname, hostnameFallbackLive&#x60; as a URL parameter &#x60;include&#x3D;&#x60;. | [optional] |
| **output** | **String** | Desired output format (json or xml). | [optional] |

### Return type

[**GeolocationResponse**](GeolocationResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json, application/xml

