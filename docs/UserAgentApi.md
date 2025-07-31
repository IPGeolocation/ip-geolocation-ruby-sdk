# IpgeolocationSdk::UserAgentApi

All URIs are relative to *https://api.ipgeolocation.io/v2*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**get_user_agent_details**](UserAgentApi.md#get_user_agent_details) | **GET** /user-agent | Get details of user-agent |
| [**parse_bulk_user_agent_strings**](UserAgentApi.md#parse_bulk_user_agent_strings) | **POST** /user-agent-bulk | Handle multiple user-agent string lookups |
| [**parse_user_agent_string**](UserAgentApi.md#parse_user_agent_string) | **POST** /user-agent | Handle single User-Agent string |


## get_user_agent_details

> <UserAgentData> get_user_agent_details(opts)

Get details of user-agent

User Agent Parser API provides the accurate browser, device, and operating system details from a User Agent String. It also provides information about crawlers and attack sources. You can use these details to customize user experience, prevent crawlers and attackers from accessing your website. 

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

api_instance = IpgeolocationSdk::UserAgentApi.new
opts = {
  user_agent: 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/601.3.9 (KHTML, like Gecko) Version/9.0.2 Safari/601.3.9', # String | 
  output: 'json' # String | Desired output format (json or xml).
}

begin
  # Get details of user-agent
  result = api_instance.get_user_agent_details(opts)
  p result
rescue IpgeolocationSdk::ApiError => e
  puts "Error when calling UserAgentApi->get_user_agent_details: #{e}"
end
```

#### Using the get_user_agent_details_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<UserAgentData>, Integer, Hash)> get_user_agent_details_with_http_info(opts)

```ruby
begin
  # Get details of user-agent
  data, status_code, headers = api_instance.get_user_agent_details_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <UserAgentData>
rescue IpgeolocationSdk::ApiError => e
  puts "Error when calling UserAgentApi->get_user_agent_details_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **user_agent** | **String** |  | [optional] |
| **output** | **String** | Desired output format (json or xml). | [optional] |

### Return type

[**UserAgentData**](UserAgentData.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json, application/xml


## parse_bulk_user_agent_strings

> <Array<UserAgentData>> parse_bulk_user_agent_strings(opts)

Handle multiple user-agent string lookups

This endpoint allows you to perform the parsing of multiple User-Angent strings (max. 50,000) at the same time. The requests count per round is equal to total User-Agent strings passed. This feature is `only available for paid plans`.

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

api_instance = IpgeolocationSdk::UserAgentApi.new
opts = {
  output: 'json', # String | Desired output format (json or xml).
  parse_bulk_user_agent_strings_request: IpgeolocationSdk::ParseBulkUserAgentStringsRequest.new # ParseBulkUserAgentStringsRequest | 
}

begin
  # Handle multiple user-agent string lookups
  result = api_instance.parse_bulk_user_agent_strings(opts)
  p result
rescue IpgeolocationSdk::ApiError => e
  puts "Error when calling UserAgentApi->parse_bulk_user_agent_strings: #{e}"
end
```

#### Using the parse_bulk_user_agent_strings_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<Array<UserAgentData>>, Integer, Hash)> parse_bulk_user_agent_strings_with_http_info(opts)

```ruby
begin
  # Handle multiple user-agent string lookups
  data, status_code, headers = api_instance.parse_bulk_user_agent_strings_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <Array<UserAgentData>>
rescue IpgeolocationSdk::ApiError => e
  puts "Error when calling UserAgentApi->parse_bulk_user_agent_strings_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **output** | **String** | Desired output format (json or xml). | [optional] |
| **parse_bulk_user_agent_strings_request** | [**ParseBulkUserAgentStringsRequest**](ParseBulkUserAgentStringsRequest.md) |  | [optional] |

### Return type

[**Array&lt;UserAgentData&gt;**](UserAgentData.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json, application/xml


## parse_user_agent_string

> <UserAgentData> parse_user_agent_string(opts)

Handle single User-Agent string

You can also provide custom User-Agent string to parse in JSON payload. This endpoint is meant to be called from server-side and is available for paid subscriptions only.

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

api_instance = IpgeolocationSdk::UserAgentApi.new
opts = {
  output: 'json', # String | Desired output format (json or xml).
  parse_user_agent_string_request: IpgeolocationSdk::ParseUserAgentStringRequest.new # ParseUserAgentStringRequest | 
}

begin
  # Handle single User-Agent string
  result = api_instance.parse_user_agent_string(opts)
  p result
rescue IpgeolocationSdk::ApiError => e
  puts "Error when calling UserAgentApi->parse_user_agent_string: #{e}"
end
```

#### Using the parse_user_agent_string_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<UserAgentData>, Integer, Hash)> parse_user_agent_string_with_http_info(opts)

```ruby
begin
  # Handle single User-Agent string
  data, status_code, headers = api_instance.parse_user_agent_string_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <UserAgentData>
rescue IpgeolocationSdk::ApiError => e
  puts "Error when calling UserAgentApi->parse_user_agent_string_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **output** | **String** | Desired output format (json or xml). | [optional] |
| **parse_user_agent_string_request** | [**ParseUserAgentStringRequest**](ParseUserAgentStringRequest.md) |  | [optional] |

### Return type

[**UserAgentData**](UserAgentData.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json, application/xml

