# IpgeolocationSdk::SecurityApi

All URIs are relative to *https://api.ipgeolocation.io/v2*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**get_bulk_ip_security_info**](SecurityApi.md#get_bulk_ip_security_info) | **POST** /security-bulk |  |
| [**get_ip_security_info**](SecurityApi.md#get_ip_security_info) | **GET** /security |  |


## get_bulk_ip_security_info

> <Array<GetBulkIpSecurityInfo200ResponseInner>> get_bulk_ip_security_info(get_bulk_ip_geolocation_request, opts)



The Bulk IP Security Lookup API can provide security details for up to `50,000` bulk IPs. This API also has parameters to customize the response, just like the single IP Security Lookup API.

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

api_instance = IpgeolocationSdk::SecurityApi.new
get_bulk_ip_geolocation_request = IpgeolocationSdk::GetBulkIpGeolocationRequest.new # GetBulkIpGeolocationRequest | 
opts = {
  include: 'location,network,currency,time_zone,user_agent,country_metadata,hostname', # String | Include optional objects like `location`, `network`.  Use comma-separated values. Example: include=location,network 
  fields: 'security.is_tor, location,', # String | Get specific fields, objects from the response.
  excludes: 'security.is_cloud_provider', # String | Exclude specific fields, objects from the response.
  output: 'json', # String | Desired output format.
  lang: 'en' # String | By default, the API responds in English. You can change the response language by passing the language code as a query parameter `lang`. Multi language feature is available only for `paid users`.
}

begin
  
  result = api_instance.get_bulk_ip_security_info(get_bulk_ip_geolocation_request, opts)
  p result
rescue IpgeolocationSdk::ApiError => e
  puts "Error when calling SecurityApi->get_bulk_ip_security_info: #{e}"
end
```

#### Using the get_bulk_ip_security_info_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<Array<GetBulkIpSecurityInfo200ResponseInner>>, Integer, Hash)> get_bulk_ip_security_info_with_http_info(get_bulk_ip_geolocation_request, opts)

```ruby
begin
  
  data, status_code, headers = api_instance.get_bulk_ip_security_info_with_http_info(get_bulk_ip_geolocation_request, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <Array<GetBulkIpSecurityInfo200ResponseInner>>
rescue IpgeolocationSdk::ApiError => e
  puts "Error when calling SecurityApi->get_bulk_ip_security_info_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **get_bulk_ip_geolocation_request** | [**GetBulkIpGeolocationRequest**](GetBulkIpGeolocationRequest.md) |  |  |
| **include** | **String** | Include optional objects like &#x60;location&#x60;, &#x60;network&#x60;.  Use comma-separated values. Example: include&#x3D;location,network  | [optional] |
| **fields** | **String** | Get specific fields, objects from the response. | [optional] |
| **excludes** | **String** | Exclude specific fields, objects from the response. | [optional] |
| **output** | **String** | Desired output format. | [optional] |
| **lang** | **String** | By default, the API responds in English. You can change the response language by passing the language code as a query parameter &#x60;lang&#x60;. Multi language feature is available only for &#x60;paid users&#x60;. | [optional] |

### Return type

[**Array&lt;GetBulkIpSecurityInfo200ResponseInner&gt;**](GetBulkIpSecurityInfo200ResponseInner.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json, application/xml


## get_ip_security_info

> <SecurityAPIResponse> get_ip_security_info(opts)



IP Security API provides security details of a given IP. It detects whether the IP is proxy, tor or bot. It also shows the proxy types of the IP (like VPN, PROXY, RELAY etc.) with it's VPN/proxy service provider making our API powerful VPN checker. It finds the IPs that are involved in spam activities. It also checks whether the IP links to a cloud provider and includes the provider's name.

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

api_instance = IpgeolocationSdk::SecurityApi.new
opts = {
  ip: '8.8.8.8', # String | query parameter 'ip'. If not provided, will be your network IP
  include: 'location,network,currency,time_zone,user_agent,country_metadata,hostname', # String | Include optional details like location and/or network.
  fields: 'security.is_tor, location,', # String | Get specific fields, objects from the response.
  excludes: 'security.is_cloud_provider', # String | Exclude specific fields, objects from the response.
  output: 'json', # String | Desired output format (json or xml).
  lang: 'en' # String | By default, the API responds in English. You can change the response language by passing the language code as a query parameter `lang`. Multi language feature is available only for `paid users`.
}

begin
  
  result = api_instance.get_ip_security_info(opts)
  p result
rescue IpgeolocationSdk::ApiError => e
  puts "Error when calling SecurityApi->get_ip_security_info: #{e}"
end
```

#### Using the get_ip_security_info_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<SecurityAPIResponse>, Integer, Hash)> get_ip_security_info_with_http_info(opts)

```ruby
begin
  
  data, status_code, headers = api_instance.get_ip_security_info_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <SecurityAPIResponse>
rescue IpgeolocationSdk::ApiError => e
  puts "Error when calling SecurityApi->get_ip_security_info_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **ip** | **String** | query parameter &#39;ip&#39;. If not provided, will be your network IP | [optional] |
| **include** | **String** | Include optional details like location and/or network. | [optional] |
| **fields** | **String** | Get specific fields, objects from the response. | [optional] |
| **excludes** | **String** | Exclude specific fields, objects from the response. | [optional] |
| **output** | **String** | Desired output format (json or xml). | [optional] |
| **lang** | **String** | By default, the API responds in English. You can change the response language by passing the language code as a query parameter &#x60;lang&#x60;. Multi language feature is available only for &#x60;paid users&#x60;. | [optional] |

### Return type

[**SecurityAPIResponse**](SecurityAPIResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json, application/xml

