# IpgeolocationSdk::ASNLookupApi

All URIs are relative to *https://api.ipgeolocation.io/v2*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**get_asn_info**](ASNLookupApi.md#get_asn_info) | **GET** /asn |  |


## get_asn_info

> <ASNResponse> get_asn_info(opts)



ASN API provides comprehensive details for an ASN including the as name,  organization name, the country of registration, associated domain, and its  type (ISP, host provider, or business). The API also shows the allocation  date of provided ASN and if it is currently allocated or not. It also contains  the routing information including peering, upstreams, and downstreams to help  understand the relationship between different ASNs.  Example Use Cases:  - Looking up ASN information for an IP address (e.g., `GET /asn?ip=8.8.8.8`)  - Retrieving ASN information for a specific ASN number (e.g., `GET /asn?asn=12345`)  - Getting peering relationships for an ASN (e.g., `GET /asn?asn=12345&include=peers`) 

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

api_instance = IpgeolocationSdk::ASNLookupApi.new
opts = {
  ip: '8.8.8.8', # String | query parameter 'ip'.
  asn: 1, # Integer | query paramter 'asn'.
  include: 'peers', # String | This parameter can have four options: a) peers b) downstreams c) upstreams d) routes e) whois_response. You may add any of them in comma-separated way. In order to get the ASN details with peering data, pass peers string in the include parameter like mentioned below.
  excludes: 'asn.date_allocated,asn.allocation_status', # String | You can exclude fields from the response according to you requirement with the exception of ip field. For example, you want to remove date_allocated and allocation_status from api response, you can put the keys in excludes parameter like this.
  fields: 'asn.organization,asn.country,asn.downstreams' # String | You can filter out only those fields which you want to see in the response by using the fields parameter. To retrieve only the AS organization, its country and downstreams in api response, you can put the keys in fields parameter like this. API will combine these fields with the default ASN response. Note: Parameters `peers, downstreams, upstreams, routes, whois_response` can be used in both `include` , and `fields`. If you use include and fields at the same time, fields parameter will be considered only.
}

begin
  
  result = api_instance.get_asn_info(opts)
  p result
rescue IpgeolocationSdk::ApiError => e
  puts "Error when calling ASNLookupApi->get_asn_info: #{e}"
end
```

#### Using the get_asn_info_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<ASNResponse>, Integer, Hash)> get_asn_info_with_http_info(opts)

```ruby
begin
  
  data, status_code, headers = api_instance.get_asn_info_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <ASNResponse>
rescue IpgeolocationSdk::ApiError => e
  puts "Error when calling ASNLookupApi->get_asn_info_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **ip** | **String** | query parameter &#39;ip&#39;. | [optional] |
| **asn** | **Integer** | query paramter &#39;asn&#39;. | [optional] |
| **include** | **String** | This parameter can have four options: a) peers b) downstreams c) upstreams d) routes e) whois_response. You may add any of them in comma-separated way. In order to get the ASN details with peering data, pass peers string in the include parameter like mentioned below. | [optional] |
| **excludes** | **String** | You can exclude fields from the response according to you requirement with the exception of ip field. For example, you want to remove date_allocated and allocation_status from api response, you can put the keys in excludes parameter like this. | [optional] |
| **fields** | **String** | You can filter out only those fields which you want to see in the response by using the fields parameter. To retrieve only the AS organization, its country and downstreams in api response, you can put the keys in fields parameter like this. API will combine these fields with the default ASN response. Note: Parameters &#x60;peers, downstreams, upstreams, routes, whois_response&#x60; can be used in both &#x60;include&#x60; , and &#x60;fields&#x60;. If you use include and fields at the same time, fields parameter will be considered only. | [optional] |

### Return type

[**ASNResponse**](ASNResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json, application/xml

