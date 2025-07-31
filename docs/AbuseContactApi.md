# IpgeolocationSdk::AbuseContactApi

All URIs are relative to *https://api.ipgeolocation.io/v2*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**get_abuse_contact_info**](AbuseContactApi.md#get_abuse_contact_info) | **GET** /abuse |  |


## get_abuse_contact_info

> <AbuseResponse> get_abuse_contact_info(opts)



The Abuse Contact API provides essential contact information to report abusive activity associated with IP addresses. By querying an IP address (IPv4 or IPv6), users receive detailed abuse contact data, including the responsible organization, abuse handling role, contact emails, phone numbers, and registered address. This enables users to swiftly take action to report and mitigate threats such as spam, DDoS attacks, and phishing.     In addition to abuse-specific contacts, the API also includes registration metadata like the registered country and abuse handle. This empowers cybersecurity teams, hosting providers, and compliance entities to take appropriate legal or administrative action. 

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

api_instance = IpgeolocationSdk::AbuseContactApi.new
opts = {
  ip: '8.8.8.8', # String | query parameter 'ip'.
  excludes: 'abuse.handle,abuse.emails', # String | You can exclude specific fields from the API response (except the ip field) by listing them in the excludes parameter as a comma-separated list. For example, you want to remove emails and handle from api response, you can put the keys in excludes parameter like this.
  fields: 'abuse.role,abuse.emails' # String | You can customize the API response by using the fields parameter to include only the specific data you need. For example, to retrieve only the role and emails, specify these keys in the fields parameter as shown below.
}

begin
  
  result = api_instance.get_abuse_contact_info(opts)
  p result
rescue IpgeolocationSdk::ApiError => e
  puts "Error when calling AbuseContactApi->get_abuse_contact_info: #{e}"
end
```

#### Using the get_abuse_contact_info_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<AbuseResponse>, Integer, Hash)> get_abuse_contact_info_with_http_info(opts)

```ruby
begin
  
  data, status_code, headers = api_instance.get_abuse_contact_info_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <AbuseResponse>
rescue IpgeolocationSdk::ApiError => e
  puts "Error when calling AbuseContactApi->get_abuse_contact_info_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **ip** | **String** | query parameter &#39;ip&#39;. | [optional] |
| **excludes** | **String** | You can exclude specific fields from the API response (except the ip field) by listing them in the excludes parameter as a comma-separated list. For example, you want to remove emails and handle from api response, you can put the keys in excludes parameter like this. | [optional] |
| **fields** | **String** | You can customize the API response by using the fields parameter to include only the specific data you need. For example, to retrieve only the role and emails, specify these keys in the fields parameter as shown below. | [optional] |

### Return type

[**AbuseResponse**](AbuseResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json, application/xml

