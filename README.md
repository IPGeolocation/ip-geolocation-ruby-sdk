# IP Geolocation API Library/SDK for Ruby

## Overview
The official **Ruby Client Library** for **[IPGeolocation.io](https://ipgeolocation.io)**'s set of APIs, provides a quick, developer friendly, way to access IP Location, Security, Timezone, Astronomy, ASN, Abuse Contact, and useragent data. Lookup your own IP or provide any IPv4, IPv6 or domain name to get structured results in Ruby, without the need for manual HTTP requests or response parsing.

- [IP Location API](https://ipgeolocation.io/ip-location-api.html): Get all-in-one unified solution for **location** (city, locality, state, country, etc.), **currency**, **network** (AS number, ASN name, organization, asn type, date of allocation, company/ISP name, company type, company domain), **timezone** , **useragent** string parsing, **security** (threat score, is_tor, is_bot, proxy_provider, cloud_provider), and **abuse contact** (route/CIDR network, country, address, email, phone numbers) information.
- [IP Security API](https://ipgeolocation.io/ip-security-api.html): Get security, network, location, hostname, timezone and useragent parsing.
- [ASN API](https://ipgeolocation.io/asn-api.html): Get ASN details along with peers, upstreams, downstreams, routes, and raw WHOIS.
- [Abuse Contact API](https://ipgeolocation.io/ip-abuse-contact-api.html): Get abuse emails, phone numbers, kind, organization, route/CIDR network and country.
- [Astronomy API](https://ipgeolocation.io/astronomy-api.html): Get sunrise, sunset, moonrise, moonset, moon phases with precise twilight period times in combination with location information.
- [Timezone API](https://ipgeolocation.io/timezone-api.html): Get timezone name, multiple time formats, daylight saving status and its details along with location information.
- [Timezone Convert API](https://ipgeolocation.io/timezone-api.html): Convert time between timezone names, geo coordinates, location addresses, IATA codes, ICAO codes, or UN/LOCODE.
- [User Agent API](https://ipgeolocation.io/user-agent-api.html): Get browser, Operating System, and device info from single or multiple Useragent string parsing.

This Ruby Gem aims to empower developers to integrate threat intelligence, personalization, fraud prevention, compliance, and analytics features directly into Ruby based applications. Whether you're enriching signup forms with ip geolocation data, localizing content, embedding threat intelligence in back-end systems, or converting time zones and currencies, the library ensures seamless, scalable integration with IPGeolocation.io’s global API infrastructure.

Based on:
- API version: 2.0.0

**Official Release:**
- Available on [**RubyGems.org**](https://rubygems.org/gems/ipgeolocation_sdk)  [![Gem Version](https://badge.fury.io/rb/ipgeolocation_sdk.svg)](https://badge.fury.io/rb/ipgeolocation_sdk)
- Source Code: [**GitHub Repository**](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk)

## Table of Contents

1. [Requirements](#requirements)
2. [Installation](#installation)
   - [From RubyGems.org](#from-rubygemsorg)
   - [From Source (Local Build)](#from-source-local-build)
   - [From GitHub](#from-github)
3. [API Documentation Links](#api-documentations)
4. [API Endpoints](#api-endpoints)
5. [Fields and Methods Availability](#fields-and-methods-availability)
6. [Authentication Setup](#authentication-setup)
   - [How to Get Your API Key](#how-to-get-your-api-key)
   - [ApiKeyAuth](#apikeyauth)
7. [Accessing API response fields](#accessing-api-response-fields)
   - [Access a specific field](#access-a-specific-field)
   - [Get JSON response](#get-json-response)
8. [IP Geolocation Examples](#ip-geolocation-examples)
   - [Developer (Free) Plan Examples](#developer-plan-examples)
   - [Standard Plan Examples](#standard-plan-examples)
   - [Advanced Plan Examples](#advanced-plan-examples)
   - [Bulk IP Geolocation Example](#bulk-ip-geolocation-example)
9. [IP Security Examples](#ip-security-examples)
   - [Get Default Security Fields](#get-default-security-fields)
   - [Include Multiple Optional Fields](#include-multiple-optional-fields)
   - [Request with Field Filtering](#request-with-field-filtering)
   - [Bulk IP Security Request](#bulk-ip-security-request)
10. [ASN API Examples](#asn-api-examples)
    - [Get ASN Information by IP Address](#get-asn-information-by-ip-address)
    - [Get ASN Information by ASN Number](#get-asn-information-by-asn-number)
    - [Combine All objects using Include](#combine-all-objects-using-include)
11. [Abuse Contact API Examples](#abuse-contact-api-examples)
    - [Lookup Abuse Contact by IP](#lookup-abuse-contact-by-ip)
    - [Lookup Abuse Contact with Specific Fields](#lookup-abuse-contact-with-specific-fields)
    - [Lookup Abuse Contact while Excluding Fields](#lookup-abuse-contact-while-excluding-fields)
12. [Timezone API Examples](#timezone-api-examples)
    - [Get Timezone by IP Address](#get-timezone-by-ip-address)
    - [Get Timezone by Timezone Name](#get-timezone-by-timezone-name)
    - [Get Timezone from Any Address](#get-timezone-from-any-address)
    - [Get Timezone from Location Coordinates](#get-timezone-from-location-coordinates)
    - [Get Timezone and Airport Details from IATA Code](#get-timezone-and-airport-details-from-iata-code)
    - [Get Timezone and City Details from UN/LOCODE](#get-timezone-and-city-details-from-unlocode)
13. [Timezone Converter Examples](#timezone-converter-examples)
    - [Convert Current Time from One Timezone to Another](#convert-current-time-from-one-timezone-to-another)
14. [User Agent API Examples](#user-agent-api-examples)
    - [Parse a Basic User Agent String](#parse-a-basic-user-agent-string)
    - [Bulk User Agent Parsing Example](#bulk-user-agent-parsing-example)
15. [Astronomy API Examples](#astronomy-api-examples)
    - [Lookup Astronomy by Coordinates](#lookup-astronomy-api-by-coordinates)
    - [Lookup Astronomy by IP Address](#lookup-astronomy-api-by-ip-address)
    - [Lookup Astronomy by Location String](#lookup-astronomy-api-by-location-string)
    - [Lookup Astronomy for Specific Date](#lookup-astronomy-api-for-a-specific-date)
    - [Lookup Location Info in Different Language](#lookup-location-info-in-different-language)
16. [Documentation for Models](#documentation-for-models)

## Requirements
- Ruby >= 2.7
- API Key from [IPGeolocation.io](https://ipgeolocation.io)

## Installation
### From RubyGems.org
Install via command line:
```bash
gem install ipgeolocation_sdk
```
May be you need to run the command with root permissions. like `sudo gem install ipgeolocation_sdk`.

Or add to your `Gemfile`:
```
gem 'ipgeolocation_sdk', '~> 1.0.0'
```

Then run:

```bash
bundle install
```

### From Source (Local Build)

To build and install locally:

```bash
gem build ipgeolocation_sdk.gemspec
gem install ./ipgeolocation_sdk-1.0.0.gem
```

### From GitHub

To install directly from a GitHub repository:

```ruby
gem 'ipgeolocation_sdk', git: 'https://github.com/IPGeolocation/ip-geolocation-ruby-sdk.git'
```
Then run:

```bash
bundle install
```

## API Documentations

The documentation below corresponds to the available APIs:
- [**Overview**](https://ipgeolocation.io/documentation.html)
- [**IP GeoLocation API**](https://ipgeolocation.io/documentation/ip-location-api.html)
- [**IP Security API**](https://ipgeolocation.io/documentation/ip-security-api.html)
- [**ASN API**](https://ipgeolocation.io/documentation/asn-api.html)
- [**IP Abuse Contact API**](https://ipgeolocation.io/documentation/ip-abuse-contact-api.html)
- [**Timezone API**](https://ipgeolocation.io/documentation/timezone-api.html)
- [**User-Agent API**](https://ipgeolocation.io/documentation/user-agent-api.html)
- [**Astronomy API**](https://ipgeolocation.io/documentation/astronomy-api.html)

For a detailed comparison of what each plan offers, visit the [Pricing Page](https://ipgeolocation.io/pricing.html).

## API Endpoints

All URIs are relative to *https://api.ipgeolocation.io/v2*

| Class                                 | Method                                                                                                                                                            | HTTP request              | Description                                                             |
|---------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------|-------------------------------------------------------------------------|
| *IpgeolocationSdk::IPGeolocationApi*  | [**get_ip_geolocation**](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/IPLocationApi.md#get_ip_geolocation)                             | **GET** /ipgeo            | Get geolocation data for a single IP address                            |
| *IpgeolocationSdk::IPGeolocationApi*  | [**get_bulk_ip_geolocation**](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/IPLocationApi.md#get_bulk_ip_geolocation)                   | **POST** /ipgeo-bulk      | Get geolocation data for multiple IP addresses in a single API request  |
| *IpgeolocationSdk::IPSecurityApi*     | [**get_ip_security_info**](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/SecurityApi.md#get_ip_security_info)                           | **GET** /security         | Retrieve security threat intelligence for a single IP                   |
| *IpgeolocationSdk::IPSecurityApi*     | [**get_bulk_ip_security_info**](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/SecurityApi.md#get_bulk_ip_security_info)                 | **POST** /security-bulk   | Retrieve security threat intelligence for multiple IPs                  |
| *IpgeolocationSdk::ASNLookupApi*      | [**get_asn_info**](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/ASNLookupApi.md#get_asn_info)                                          | **GET** /asn              | Get details of any ASN number or associated IP address                  |
| *IpgeolocationSdk::AbuseContactApi*   | [**get_abuse_contact_info**](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/AbuseContactApi.md#get_abuse_contact_info)                   | **GET** /abuse            | Retrieve abuse reporting contact information for a given IP address     |
| *IpgeolocationSdk::AstronomyApi*      | [**get_astronomy_details**](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/AstronomyApi.md#get_astronomy_details)                        | **GET** /astronomy        | Get sunrise, sunset, moonrise, moonset, and related data for a location |
| *IpgeolocationSdk::TimezoneApi*       | [**get_timezone_info**](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/TimezoneApi.md#get_timezone_info)                                 | **GET** /timezone         | Timezone information details                                            |
| *IpgeolocationSdk::TimeConversionApi* | [**convert_time_between_timezones**](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/TimeConversionApi.md#convert_time_between_timezones) | **GET** /timezone/convert | Convert time between two specified timezones                            |
| *IpgeolocationSdk::UserAgentApi*      | [**get_user_agent_details**](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/UserAgentApi.md#get_user_agent_details)                      | **GET** /user-agent       | Get details of user-agent                                               |
| *IpgeolocationSdk::UserAgentApi*      | [**parse_bulk_user_agent_strings**](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/UserAgentApi.md#parse_bulk_user_agent_strings)        | **POST** /user-agent-bulk | Handle multiple user-agent string lookups                               |

## Fields and Methods Availability
IP Geolocation offers four plans from billing point of view: **Free, Standard, Security, Advance**. The availability of each method calling from the respective class, over all plans are presented below.

| Class                                 | Method                                                                                                                                                            | Free | Standard | Security | Advance |
|---------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|:----:|:--------:|:--------:|:-------:|
| *IpgeolocationSdk::IPGeolocationApi*  | [**get_ip_geolocation**](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/IPLocationApi.md#get_ip_geolocation)                             |  ✔   |    ✔     |    ✖     |    ✔    |
| *IpgeolocationSdk::IPGeolocationApi*  | [**get_bulk_ip_geolocation**](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/IPLocationApi.md#get_bulk_ip_geolocation)                   |  ✖   |    ✔     |    ✖     |    ✔    |
| *IpgeolocationSdk::IPSecurityApi*     | [**get_ip_security_info**](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/SecurityApi.md#get_ip_security_info)                           |  ✖   |    ✖     |    ✔     |    ✖    |
| *IpgeolocationSdk::IPSecurityApi*     | [**get_bulk_ip_security_info**](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/SecurityApi.md#get_bulk_ip_security_info)                 |  ✖   |    ✖     |    ✔     |    ✖    |
| *IpgeolocationSdk::ASNLookupApi*      | [**get_asn_info**](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/ASNLookupApi.md#get_asn_info)                                          |  ✖   |    ✖     |    ✖     |    ✔    |
| *IpgeolocationSdk::AbuseContactApi*   | [**get_abuse_contact_info**](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/AbuseContactApi.md#get_abuse_contact_info)                   |  ✖   |    ✖     |    ✖     |    ✔    |
| *IpgeolocationSdk::AstronomyApi*      | [**get_astronomy_details**](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/AstronomyApi.md#get_astronomy_details)                        |  ✔   |    ✔     |    ✔     |    ✔    |
| *IpgeolocationSdk::TimezoneApi*       | [**get_timezone_info**](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/TimezoneApi.md#get_timezone_info)                                 |  ✔   |    ✔     |    ✔     |    ✔    |
| *IpgeolocationSdk::TimeConversionApi* | [**convert_time_between_timezones**](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/TimeConversionApi.md#convert_time_between_timezones) |  ✔   |    ✔     |    ✔     |    ✔    |
| *IpgeolocationSdk::UserAgentApi*      | [**get_user_agent_details**](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/UserAgentApi.md#get_user_agent_details)                      |  ✔   |    ✔     |    ✔     |    ✔    |
| *IpgeolocationSdk::UserAgentApi*      | [**parse_bulk_user_agent_strings**](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/UserAgentApi.md#parse_bulk_user_agent_strings)        |  ✖   |    ✔     |    ✔     |    ✔    |

> [!TIP]
> The availability of fields in every API endpoint across Free and Paid plans is provided in the **_Reference Table_** within each respective API Documentation. e.g., for IPGeolocationApi, please visit [https://ipgeolocation.io/documentation/ip-location-api.html#reference-to-ipgeolocation-api-response](https://ipgeolocation.io/documentation/ip-location-api.html#reference-to-ipgeolocation-api-response).

## Authentication Setup
To authenticate API requests, you need to get an API key from [ipgeolocation.io](https://ipgeolocation.io/).

### How to Get Your API Key

1. **Sign up** here: [https://app.ipgeolocation.io/signup](https://app.ipgeolocation.io/signup)
2. **(optional)** Verify your email, if you signed up using email.
3. **Log in** to your account: [https://app.ipgeolocation.io/login](https://app.ipgeolocation.io/login)
4. After logging in, navigate to your **Dashboard** to find your API key: [https://app.ipgeolocation.io/dashboard](https://app.ipgeolocation.io/dashboard)

<a id="ApiKeyAuth"></a>
### ApiKeyAuth
Once you've obtained the api key, configure your API client as follows:

The client must configure the authentication and authorization parameters in accordance with the API server security
policy.

```ruby
# Load the gem
require 'ipgeolocation_sdk'

# Setup authorization
IpgeolocationSdk.configure do |config|
  config.api_key['apiKey'] = 'YOUR API KEY'
end
```

## Accessing API response fields
The response returned by the library can be accessed in the following ways:
### Access a specific field
```ruby
require 'ipgeolocation_sdk'

IpgeolocationSdk.configure do |config|
   config.api_key['apiKey'] = 'YOUR API KEY'
end

geo = IpgeolocationSdk::IPGeolocationApi.new
begin
   opts = { ip: "8.8.8.8"}
   result = geo.get_ip_geolocation(opts)
   
   # Get specific field from response with dot separated path 
   puts "IP: #{result.ip}"
   puts "Country: #{result.location.country_name}"
   puts "City: #{result.location.city}"
   puts "Currency name: #{result.currency.name}"
rescue IpgeolocationSdk::ApiError => e
   puts "API Error: #{e}"
end
```
Sample Response:
```text
IP: 8.8.8.8
Country: United States
City: Mountain View
Currency name: US Dollar
```

### Get JSON response
To get the JSON response in a pretty formatted way:
```ruby
require 'ipgeolocation_sdk'

IpgeolocationSdk.configure do |config|
   config.api_key['apiKey'] = 'YOUR API KEY'
end

geo = IpgeolocationSdk::IPGeolocationApi.new

begin
   opts = { ip: "8.8.8.8"}
   result = geo.get_ip_geolocation(opts)
   
   # Get pretty JSON response proper formatted
   puts JSON.pretty_generate(result.to_hash)
rescue IpgeolocationSdk::ApiError => e
   puts "API Error: #{e}"
end
```

Or without the `JSON` module
```ruby
require 'ipgeolocation_sdk'

IpgeolocationSdk.configure do |config|
   config.api_key['apiKey'] = 'YOUR API KEY'
end

geo = IpgeolocationSdk::IPGeolocationApi.new

begin
   opts = { ip: "8.8.8.8"}
   result = geo.get_ip_geolocation(opts)
   
   # Use sdk's to_json method instead
   puts result.to_hash.to_json
rescue IpgeolocationSdk::ApiError => e
   puts "API Error: #{e}"
end
```
Sample Response:

```json
{
   "ip": "8.8.8.8",
   "location": {
      "continent_code": "NA",
      "continent_name": "North America",
      "country_code2": "US",
      "country_code3": "USA",
      "country_name": "United States",
      "country_name_official": "United States of America",
      "country_capital": "Washington, D.C.",
      "state_prov": "California",
      "state_code": "US-CA",
      "district": "Santa Clara",
      "city": "Mountain View",
      "zipcode": "94043-1351",
      "latitude": "37.42240",
      "longitude": "-122.08421",
      "is_eu": false,
      "country_flag": "https://ipgeolocation.io/static/flags/us_64.png",
      "geoname_id": "6301403",
      "country_emoji": "🇺🇸"
   },
   "country_metadata": {
      "calling_code": "+1",
      "tld": ".us",
      "languages": [
         "en-US",
         "es-US",
         "haw",
         "fr"
      ]
   },
   "currency": {
      "code": "USD",
      "name": "US Dollar",
      "symbol": "$"
   }
}
```

## IP Geolocation Examples
This section provides usage examples of the `get_ip_geolocation()` method from the SDK across Free, Standard, and Advanced subscription tiers. Each example highlights different combinations of parameters: `fields`, `include`, and `excludes`.

**Parameters**

- `fields`: Use this parameter to include specific fields in the response.

- `excludes`: Use this parameter to omit specific fields from the response.

- `include`: Use this parameter to add optional modules to the response, such as:
  - `security`
  - `user_agent`
  - `hostname`
  - `liveHostname`
  - `hostnameFallbackLive`
  - `abuse`
  - `dma`
  - `time_zone`

For complete details, refer to the official documentation: [IP Geolocation API Documentation](https://ipgeolocation.io/documentation/ip-location-api.html)

The `ip` parameter in the SDK can accept any valid IPv4 address, IPv6 address, or domain name. If the `ip` option is not used or the parameter is omitted, the library will return information about the public IP address of the device or server where the library is executed.


### Developer Plan Examples
#### Get Default Fields
```ruby
geolocation_instance = IpgeolocationSdk::IPGeolocationApi.new
begin
   get_geolocation_opts = { 
      ip: "8.8.8.8"
   }
   result = geolocation_instance.get_ip_geolocation(get_geolocation_opts)
   puts result.to_hash.to_json
rescue IpgeolocationSdk::ApiError => e
   puts "Error calling GeolocationApi: #{e}"
end
```
Sample Response:

```json
{
   "ip": "8.8.8.8",
   "location": {
      "continent_code": "NA",
      "continent_name": "North America",
      "country_code2": "US",
      "country_code3": "USA",
      "country_name": "United States",
      "country_name_official": "United States of America",
      "country_capital": "Washington, D.C.",
      "state_prov": "California",
      "state_code": "US-CA",
      "district": "Santa Clara",
      "city": "Mountain View",
      "zipcode": "94043-1351",
      "latitude": "37.42240",
      "longitude": "-122.08421",
      "is_eu": false,
      "country_flag": "https://ipgeolocation.io/static/flags/us_64.png",
      "geoname_id": "6301403",
      "country_emoji": "🇺🇸"
   },
   "country_metadata": {
      "calling_code": "+1",
      "tld": ".us",
      "languages": [
         "en-US",
         "es-US",
         "haw",
         "fr"
      ]
   },
   "currency": {
      "code": "USD",
      "name": "US Dollar",
      "symbol": "$"
   }
}
```
Filtering Specific Fields from the Response (Use of `exclude` and `fields`)
```ruby
get_geolocation_opts = {
  ip: "8.8.4.4",
  fields: "location",
  excludes: "location.continent_code,location.continent_name"
}
geolocation_instance = IpgeolocationSdk::IPGeolocationApi.new
begin 
    result = geolocation_instance.get_ip_geolocation(get_geolocation_opts)
    puts result.to_hash.to_json
rescue IpgeolocationSdk::ApiError => e
    puts "Error calling GeolocationApi: #{e}"
end
```
Sample Response:
```json
{
   "ip": "8.8.4.4",
   "location": {
      "country_code2": "US",
      "country_code3": "USA",
      "country_name": "United States",
      "country_name_official": "United States of America",
      "country_capital": "Washington, D.C.",
      "state_prov": "California",
      "state_code": "US-CA",
      "district": "Santa Clara",
      "city": "Mountain View",
      "zipcode": "94043-1351",
      "latitude": "37.42240",
      "longitude": "-122.08421",
      "is_eu": false,
      "country_flag": "https://ipgeolocation.io/static/flags/us_64.png",
      "geoname_id": "6301403",
      "country_emoji": "🇺🇸"
   }
}
```
### Standard Plan Examples
#### Get Standard plan default Fields
```ruby
get_geolocation_opts = {
  ip: "8.8.8.8"
}
geolocation_instance = IpgeolocationSdk::IPGeolocationApi.new
begin 
    result = geolocation_instance.get_ip_geolocation(get_geolocation_opts)
    puts result.to_hash.to_json
rescue IpgeolocationSdk::ApiError => e
    puts "Error calling GeolocationApi: #{e}"
end
```
Sample Response:
```json
{
   "ip": "8.8.8.8",
   "location": {
      "continent_code": "NA",
      "continent_name": "North America",
      "country_code2": "US",
      "country_code3": "USA",
      "country_name": "United States",
      "country_name_official": "United States of America",
      "country_capital": "Washington, D.C.",
      "state_prov": "California",
      "state_code": "US-CA",
      "district": "Santa Clara",
      "city": "Mountain View",
      "zipcode": "94043-1351",
      "latitude": "37.42240",
      "longitude": "-122.08421",
      "is_eu": false,
      "country_flag": "https://ipgeolocation.io/static/flags/us_64.png",
      "geoname_id": "6301403",
      "country_emoji": "🇺🇸"
   },
   "country_metadata": {
      "calling_code": "+1",
      "tld": ".us",
      "languages": [
         "en-US",
         "es-US",
         "haw",
         "fr"
      ]
   },
   "network": {
      "asn": {
         "as_number": "AS15169",
         "organization": "Google LLC",
         "country": "US"
      },
      "company": {
         "name": "Google LLC"
      }
   },
   "currency": {
      "code": "USD",
      "name": "US Dollar",
      "symbol": "$"
   }
}
```
#### Retrieving Geolocation Data in Multiple Languages
Here is an example to get the geolocation data for IP address '2001:4230:4890::1' in French language:
```ruby
get_geolocation_opts = {
  ip: "2001:4230:4890::1",
  lang: "fr"
}
geolocation_instance = IpgeolocationSdk::IPGeolocationApi.new
begin 
    result = geolocation_instance.get_ip_geolocation(get_geolocation_opts)
    puts result.to_hash.to_json
rescue IpgeolocationSdk::ApiError => e
    puts "Error calling GeolocationApi: #{e}"
end
```
Sample Response
```json
{
  "ip": "2001:4230:4890:0:0:0:0:1",
  "location": {
    "continent_code": "AF",
    "continent_name": "Afrique",
    "country_code2": "MU",
    "country_code3": "MUS",
    "country_name": "Maurice",
    "country_name_official": "",
    "country_capital": "Port Louis",
    "state_prov": "Wilhems des plaines",
    "state_code": "MU-PW",
    "district": "Quatre Bornes",
    "city": "Quatre Bornes",
    "zipcode": "72201",
    "latitude": "-20.24304",
    "longitude": "57.49631",
    "is_eu": false,
    "country_flag": "https://ipgeolocation.io/static/flags/mu_64.png",
    "geoname_id": "1106777",
    "country_emoji": "🇲🇺"
  },
  "country_metadata": {
    "calling_code": "+230",
    "tld": ".mu",
    "languages": [
      "en-MU",
      "bho",
      "fr"
    ]
  },
  "network": {
    "asn": {
      "as_number": "AS52095",
      "organization": "Netassist International s.r.o.",
      "country": "CZ"
    },
    "company": {
      "name": "African Network Information Center AfriNIC Ltd"
    }
  },
  "currency": {
    "code": "MUR",
    "name": "Mauritius Rupee",
    "symbol": "₨"
  }
}
```

#### Include HostName, Timezone and User-Agent
```ruby
get_geolocation_opts = {
  ip: "4.5.6.7",
  include: "hostname,time_zone,user_agent"
}
geolocation_instance = IpgeolocationSdk::IPGeolocationApi.new
begin 
    result = geolocation_instance.get_ip_geolocation(get_geolocation_opts)
    puts result.to_hash.to_json
rescue IpgeolocationSdk::ApiError => e
    puts "Error calling GeolocationApi: #{e}"
end
```
Sample Response
```json
{
  "ip": "4.5.6.7",
  "hostname": "4.5.6.7",
  "location": {
    "continent_code": "NA",
    "continent_name": "North America",
    "country_code2": "US",
    "country_code3": "USA",
    "country_name": "United States",
    "country_name_official": "United States of America",
    "country_capital": "Washington, D.C.",
    "state_prov": "Louisiana",
    "state_code": "US-LA",
    "district": "Ouachita",
    "city": "Monroe",
    "zipcode": "71203-2041",
    "latitude": "32.58997",
    "longitude": "-92.06862",
    "is_eu": false,
    "country_flag": "https://ipgeolocation.io/static/flags/us_64.png",
    "geoname_id": "4343811",
    "country_emoji": "🇺🇸"
  },
  "country_metadata": {
    "calling_code": "+1",
    "tld": ".us",
    "languages": [
      "en-US",
      "es-US",
      "haw",
      "fr"
    ]
  },
  "network": {
    "asn": {
      "as_number": "AS3356",
      "organization": "Level 3 Parent, LLC",
      "country": "US"
    },
    "company": {
      "name": "Level 3 Parent, LLC"
    }
  },
  "currency": {
    "code": "USD",
    "name": "US Dollar",
    "symbol": "$"
  },
  "time_zone": {
    "name": "America/Chicago",
    "offset": -6,
    "offset_with_dst": -6,
    "current_time": "2025-12-24 01:54:01.954-0600",
    "current_time_unix": 1766562841.954,
    "is_dst": false,
    "dst_savings": 0,
    "dst_exists": true,
    "dst_start": {
      "utc_time": "2025-03-09 TIME 08",
      "duration": "+1H",
      "gap": true,
      "date_time_after": "2025-03-09 TIME 03",
      "date_time_before": "2025-03-09 TIME 02",
      "overlap": false
    },
    "dst_end": {
      "utc_time": "2025-11-02 TIME 07",
      "duration": "-1H",
      "gap": false,
      "date_time_after": "2025-11-02 TIME 01",
      "date_time_before": "2025-11-02 TIME 02",
      "overlap": true
    }
  },
  "user_agent": {
    "user_agent_string": "OpenAPI-Generator/1.0.0/ruby",
    "name": "OpenAPI-Generator",
    "type": "Special",
    "version": "1.0.0",
    "version_major": "1",
    "device": {
      "name": "Unknown",
      "type": "Unknown",
      "brand": "Unknown",
      "cpu": "Unknown"
    },
    "engine": {
      "name": "Unknown",
      "type": "Unknown",
      "version": "??",
      "version_major": "??"
    },
    "operating_system": {
      "name": "Unknown",
      "type": "Unknown",
      "version": "??",
      "version_major": "??",
      "build": "??"
    }
  }
}
```
> [!NOTE]
>
> The IP Geolocation API supports hostname lookup for all paid subscriptions. However, this is not included by default. To enable hostname resolution, use the `include` parameter with one of the following options:
>
> - `hostname`: Performs a quick lookup using the internal hostname database. If no match is found, the IP is returned as-is. This is fast but may produce incomplete results.
> - `liveHostname`: Queries live sources for accurate hostname resolution. This may increase response time.
> - `hostnameFallbackLive`: Attempts the internal database first, and falls back to live sources if no result is found. This option provides a balance of speed and reliability.

### Advanced Plan Examples
#### Include DMA, Abuse and Security

```ruby
get_geolocation_opts = {
  ip: "8.8.8.8",
  include: "dma,abuse,security",
  excludes: "location.country_flag,location.country_emoji"
}
geolocation_instance = IpgeolocationSdk::IPGeolocationApi.new
begin 
    result = geolocation_instance.get_ip_geolocation(get_geolocation_opts)
    puts result.to_hash.to_json
rescue IpgeolocationSdk::ApiError => e
    puts "Error calling GeolocationApi: #{e}"
end
```
Sample Response:
```json
{
  "ip": "8.8.8.8",
  "location": {
    "continent_code": "NA",
    "continent_name": "North America",
    "country_code2": "US",
    "country_code3": "USA",
    "country_name": "United States",
    "country_name_official": "United States of America",
    "country_capital": "Washington, D.C.",
    "state_prov": "California",
    "state_code": "US-CA",
    "district": "Santa Clara",
    "city": "Mountain View",
    "zipcode": "94043-1351",
    "latitude": "37.42240",
    "longitude": "-122.08421",
    "is_eu": false,
    "geoname_id": "6301403",
    "accuracy_radius": "21.485",
    "locality": "Mountain View",
    "dma_code": "807"
  },
  "country_metadata": {
    "calling_code": "+1",
    "tld": ".us",
    "languages": [
      "en-US",
      "es-US",
      "haw",
      "fr"
    ]
  },
  "network": {
    "asn": {
      "as_number": "AS15169",
      "organization": "Google LLC",
      "country": "US",
      "asn_name": "GOOGLE",
      "type": "BUSINESS",
      "domain": "google.com",
      "date_allocated": "2012-02-24T00:00",
      "allocation_status": "",
      "num_of_ipv4_routes": "1008",
      "num_of_ipv6_routes": "136",
      "rir": "ARIN"
    },
    "connection_type": "",
    "company": {
      "name": "Google LLC",
      "type": "Hosting",
      "domain": "google.com"
    }
  },
  "currency": {
    "code": "USD",
    "name": "US Dollar",
    "symbol": "$"
  },
  "security": {
    "threat_score": 0,
    "is_tor": false,
    "is_proxy": false,
    "proxy_type": "",
    "proxy_provider": "",
    "is_anonymous": false,
    "is_known_attacker": false,
    "is_spam": false,
    "is_bot": false,
    "is_cloud_provider": false,
    "cloud_provider": ""
  },
  "abuse": {
    "route": "8.8.8.0/24",
    "country": "",
    "handle": "ABUSE5250-ARIN",
    "name": "Abuse",
    "organization": "Abuse",
    "role": "abuse",
    "kind": "group",
    "address": "1600 Amphitheatre Parkway\nMountain View\nCA\n94043\nUnited States",
    "emails": [
      "network-abuse@google.com"
    ],
    "phone_numbers": [
      "+1-650-253-0000"
    ]
  }
}
```
These examples demonstrate typical usage of the IP Geolocation API with different subscription tiers. Use `fields` to specify exactly which data to receive, `include` for optional data like security and user agent, and `excludes` to omit specific keys from the response.

> [!NOTE]
> All features available in the Free plan are also included in the Standard and Advanced plans. Similarly, all features of the Standard plan are available in the Advanced plan.

### Bulk IP Geolocation Example
The SDK also supports bulk IP geolocation requests using the `get_bulk_ip_geolocation()` method. All parameters like `fields`, `include`, and `excludes` can also be used in bulk requests.

```ruby
post_geolocation_opts = {
    ips: ["8.8.8.8", "asdasd"],
    include: "security",
    excludes: "location.country_flag,location.country_emoji"
}
geolocation_instance = IpgeolocationSdk::IPGeolocationApi.new
begin 
    result = geolocation_instance.get_bulk_ip_geolocation(post_geolocation_opts)
    result.each do |item| 
        if IpgeolocationSdk::BulkIPGeolocation.is_success?(item) # GeolocationResponse
            p item.ip
        elsif IpgeolocationSdk::BulkIPGeolocation.is_error?(item) # ErrorResponse
            p item.message
        end
    end
rescue IpgeolocationSdk::ApiError => e
    puts "Error calling GeolocationApi: #{e}"
end
```

## IP Security Examples

This section provides usage examples of the `get_ip_security_info()` method from the SDK across various subscription tiers. Each example demonstrates different ways to query threat intelligence and risk metadata using parameters like fields, excludes, and optional modules.

For full API specifications, refer to the [official IP Security API documentation](https://ipgeolocation.io/documentation/ip-security-api.html).

### Get Default Security Fields

```ruby
get_ip_security_opts = {
    ip: "2.56.188.34"
}
security_instance = IpgeolocationSdk::IPSecurityApi.new
begin 
    result = security_instance.get_ip_security_info(get_ip_security_opts)
    puts result.to_hash.to_json
rescue IpgeolocationSdk::ApiError => e
    puts "Error calling GeolocationApi: #{e}"
end
```

Sample Response
```json
{
  "ip": "2.56.188.34",
  "security": {
    "threat_score": 80,
    "is_tor": false,
    "is_proxy": true,
    "proxy_type": "PROXY",
    "proxy_provider": "Zyte Proxy",
    "is_anonymous": true,
    "is_known_attacker": true,
    "is_spam": false,
    "is_bot": false,
    "is_cloud_provider": false,
    "cloud_provider": ""
  }
}
```
### Include Multiple Optional Fields
```ruby
get_ip_security_opts = {
    ip: "2.56.188.34",
    include: "location,network,currency,time_zone,user_agent,country_metadata,hostname"
}
security_instance = IpgeolocationSdk::IPSecurityApi.new
begin 
    result = security_instance.get_ip_security_info(get_ip_security_opts)
    puts result.to_hash.to_json
rescue IpgeolocationSdk::ApiError => e
    puts "Error calling GeolocationApi: #{e}"
end
```

> [!NOTE]
> You can get all the available fields in standard plan in combination with security data, when subscribed to security plan.

### Request with Field Filtering

```ruby
get_ip_security_opts = {
    ip: "195.154.221.54",
    fields: "security.is_tor,security.is_proxy,security.is_bot,security.is_spam"
}
security_instance = IpgeolocationSdk::IPSecurityApi.new
begin 
    result = security_instance.get_ip_security_info(get_ip_security_opts)
    puts result.to_hash.to_json
rescue IpgeolocationSdk::ApiError => e
    puts "Error calling SecurityApi: #{e}"
end
```
Sample Response
```json
{
  "ip": "195.154.221.54",
  "security": {
    "is_tor": false,
    "is_proxy": true,
    "is_spam": false,
    "is_bot": false
  }
}
```
### Bulk IP Security Request
The SDK also supports bulk IP Security requests using the `get_bulk_ip_security_info()` method. All parameters like `fields`, `include`, and `excludes` can also be used in bulk requests.

```ruby
post_ip_security_opts = {
  ips: ["2.56.188.34","2.56.188.35"],
  include: "location,network",
  fields: "security.threat_score,location.country_name"
}

security_instance = IpgeolocationSdk::IPSecurityApi.new
begin
  result = security_instance.get_bulk_ip_security_info(post_ip_security_opts)
  result.each do |item|
    if IpgeolocationSdk::BulkIPSecurity.is_success?(item) # SecurityAPIResponse
      p item.security.threat_score
    elsif IpgeolocationSdk::BulkIPSecurity.is_error?(item) # ErrorResponse
      p item.message
    end
  end
rescue IpgeolocationSdk::ApiError => e
  puts "Error calling SecurityApi: #{e}"
end
```

## ASN API Examples

This section provides usage examples of the `get_asn_info()` method from the SDK. These methods allow developers to retrieve detailed ASN-level network data either by ASN number or by IP address.

> [!NOTE]
> ASN API is only available in the Advanced Plan.

Refer to the [ASN API documentation](https://ipgeolocation.io/documentation/asn-api.html) for a detailed list of supported fields and behaviors.

### Get ASN Information by IP Address

```ruby
asn_opts = {
  ip: '8.8.8.8',
}
asn_instance = IpgeolocationSdk::ASNLookupApi.new
begin
  result = asn_instance.get_asn_info(asn_opts)
  puts result.to_hash.to_json
rescue IpgeolocationSdk::ApiError => e
  puts "Error calling ASNLookupApi: #{e}"
end
```
Sample Response
```json
{
  "ip": "8.8.8.8",
  "asn": {
    "as_number": "AS15169",
    "organization": "Google LLC",
    "country": "US",
    "asn_name": "GOOGLE",
    "type": "BUSINESS",
    "domain": "google.com",
    "date_allocated": "2012-02-24T00:00",
    "allocation_status": "",
    "num_of_ipv4_routes": "1020",
    "num_of_ipv6_routes": "136",
    "rir": "ARIN"
  }
}
```
### Get ASN Information by ASN Number

```ruby
asn_opts = {
  asn: 15169,
}
asn_instance = IpgeolocationSdk::ASNLookupApi.new
begin
  result = asn_instance.get_asn_info(asn_opts)
  puts result.to_hash.to_json
rescue IpgeolocationSdk::ApiError => e
  puts "Error calling ASNLookupApi: #{e}"
end
```
Sample Response
```json
{
  "asn": {
    "as_number": "AS15169",
    "organization": "Google LLC",
    "country": "US",
    "asn_name": "GOOGLE",
    "type": "BUSINESS",
    "domain": "google.com",
    "date_allocated": "2012-02-24T00:00",
    "allocation_status": "",
    "num_of_ipv4_routes": "1020",
    "num_of_ipv6_routes": "136",
    "rir": "ARIN"
  }
}
```

### Combine All objects using Include
```ruby
asn_opts = {
    asn: 12,
    include: "peers,downstreams,upstreams,routes,whois_response"
}
asn_instance = IpgeolocationSdk::ASNLookupApi.new
begin
  result = asn_instance.get_asn_info(asn_opts)
  p result
rescue IpgeolocationSdk::ApiError => e
  puts "Error calling ASNLookupApi: #{e}"
end
```
Sample Response
```json
{
  "asn": {
    "as_number": "AS12",
    "organization": "New York University",
    "country": "US",
    "asn_name": "NYU-DOMAIN",
    "type": "EDUCATION",
    "domain": "nyu.edu",
    "date_allocated": "2023-05-25T00:00",
    "allocation_status": "",
    "num_of_ipv4_routes": "11",
    "num_of_ipv6_routes": "1",
    "rir": "ARIN",
    "routes": [
      "192.76.177.0/24",
      "...",
      "216.165.103.0/24"
    ],
    "upstreams": [
      {
        "as_number": "AS3269",
        "description": "Telecom Italia S.p.A.",
        "country": "IT"
      },
      "...",
      {
        "as_number": "AS137",
        "description": "Consortium GARR",
        "country": "IT"
      }
    ],
    "downstreams": [
      {
        "as_number": "AS394666",
        "description": "NYU Langone Health",
        "country": "US"
      },
      {
        "as_number": "AS54965",
        "description": "Polytechnic Institute of NYU",
        "country": "US"
      }
    ],
    "peers": [
      {
        "as_number": "AS3269",
        "description": "Telecom Italia S.p.A.",
        "country": "IT"
      },
      "...",
      {
        "as_number": "AS54965",
        "description": "Polytechnic Institute of NYU",
        "country": "US"
      }
    ],
    "whois_response": "<raw-whois-response>"
  }
}
```

## Abuse Contact API Examples
This section demonstrates how to use the `get_abuse_contact_info()` method of the AbuseContact API. This API helps security teams, hosting providers, and compliance professionals quickly identify the correct abuse reporting contacts for any IPv4 or IPv6 address. You can retrieve data like the responsible organization, role, contact emails, phone numbers, and address to take appropriate mitigation action against abusive or malicious activity.

> [!NOTE] 
> Abuse Contact API is only available in Advanced Plan.

Refer to the official [Abuse Contact API documentation](https://ipgeolocation.io/documentation/ip-abuse-contact-api.html) for details on all available fields.
### Lookup Abuse Contact by IP
```ruby
abuse_opts = {
  ip: '1.0.0.0',
}
abuse_instance = IpgeolocationSdk::AbuseContactApi.new
begin 
    result = abuse_instance.get_abuse_contact_info(abuse_opts)
    puts result.to_hash.to_json
rescue IpgeolocationSdk::ApiError => e
    puts "Error calling AbuseContactApi: #{e}"
end
```
Sample Response:
```json
{
  "ip": "1.0.0.0",
  "abuse": {
    "route": "1.0.0.0/24",
    "country": "AU",
    "handle": "IRT-APNICRANDNET-AU",
    "name": "IRT-APNICRANDNET-AU",
    "organization": "",
    "role": "abuse",
    "kind": "group",
    "address": "PO Box 3646\nSouth Brisbane, QLD 4101\nAustralia",
    "emails": [
      "helpdesk@apnic.net"
    ],
    "phone_numbers": [
      "+61 7 3858 3100"
    ]
  }
}
```

### Lookup Abuse Contact with Specific Fields
```ruby
abuse_opts = {
  ip: '1.2.3.4',
  fields: 'abuse.role,abuse.emails',
}
abuse_instance = IpgeolocationSdk::AbuseContactApi.new
begin 
    result = abuse_instance.get_abuse_contact_info(abuse_opts)
    puts result.to_hash.to_json
rescue IpgeolocationSdk::ApiError => e
    puts "Error calling AbuseContactApi: #{e}"
end
```
Sample Response:
```json
{
  "ip": "1.2.3.4",
  "abuse": {
    "role": "abuse",
    "emails": [
      "helpdesk@apnic.net"
    ]
  }
}
```
### Lookup Abuse Contact while Excluding Fields
```ruby
abuse_opts = {
  ip: '9.9.9.9',
  excludes: 'abuse.handle,abuse.emails',
}
abuse_instance = IpgeolocationSdk::AbuseContactApi.new
begin 
    result = abuse_instance.get_abuse_contact_info(abuse_opts)
    puts result.to_hash.to_json
rescue IpgeolocationSdk::ApiError => e
    puts "Error calling AbuseContactApi: #{e}"
end
```
Sample Response:
```json
{
  "ip": "9.9.9.9",
  "abuse": {
    "route": "9.9.9.0/24",
    "country": "",
    "name": "Quad9 Abuse",
    "organization": "Quad9 Abuse",
    "role": "abuse",
    "kind": "group",
    "address": "1442 A Walnut Street Ste 501\nBerkeley\nCA\n94709\nUnited States",
    "phone_numbers": [
      "+1-415-831-3129"
    ]
  }
}
```

## Timezone API Examples

This section provides usage examples of the `get_timezone_info()` method from the SDK, showcasing how to fetch timezone and time-related data using different query types — IP address, latitude/longitude, and timezone ID.

For full API specifications, refer to the [Timezone API documentation](https://ipgeolocation.io/documentation/timezone-api.html).

### Get Timezone by IP Address

```ruby
time_zone_opts = {
    ip: "8.8.8.8"
}
time_zone_instance = IpgeolocationSdk::TimezoneApi.new
begin 
    result = time_zone_instance.get_timezone_info(time_zone_opts)
    puts result.to_hash.to_json
rescue IpgeolocationSdk::ApiError => e
    puts "Error calling TimezoneApi: #{e}"
end
```
Sample Response
```json
{
  "ip": "8.8.8.8",
  "location": {
    "continent_code": "NA",
    "continent_name": "North America",
    "country_code2": "US",
    "country_code3": "USA",
    "country_name": "United States",
    "country_name_official": "United States of America",
    "is_eu": false,
    "state_prov": "California",
    "state_code": "US-CA",
    "district": "Santa Clara",
    "city": "Mountain View",
    "zipcode": "94043-1351",
    "latitude": "37.42240",
    "longitude": "-122.08421"
  },
  "time_zone": {
    "name": "America/Los_Angeles",
    "offset": -8,
    "offset_with_dst": -8,
    "date": "2025-12-24",
    "date_time": "2025-12-24 02:45:59",
    "date_time_txt": "Wednesday, December 24, 2025 02:45:59",
    "date_time_wti": "Wed, 24 Dec 2025 02:45:59 -0800",
    "date_time_ymd": "2025-12-24 02:45:59 -0800",
    "date_time_unix": 1766573159.034,
    "time_24": "02:45:59",
    "time_12": "02:45:59 AM",
    "week": 52,
    "month": 12,
    "year": 2025,
    "year_abbr": "25",
    "is_dst": false,
    "dst_savings": 0,
    "dst_exists": true,
    "dst_start": {
      "utc_time": "2025-03-09 TIME 10",
      "duration": "+1H",
      "gap": true,
      "date_time_after": "2025-03-09 TIME 03",
      "date_time_before": "2025-03-09 TIME 02",
      "overlap": false
    },
    "dst_end": {
      "utc_time": "2025-11-02 TIME 09",
      "duration": "-1H",
      "gap": false,
      "date_time_after": "2025-11-02 TIME 01",
      "date_time_before": "2025-11-02 TIME 02",
      "overlap": true
    }
  }
}
```
### Get Timezone by Timezone Name

```ruby
time_zone_opts = {
    tz: "Europe/London"
}
time_zone_instance = IpgeolocationSdk::TimezoneApi.new
begin 
    result = time_zone_instance.get_timezone_info(time_zone_opts)
    puts result.to_hash.to_json
rescue IpgeolocationSdk::ApiError => e
    puts "Error calling TimezoneApi: #{e}"
end
```
Sample Response
```json
{
  "time_zone": {
    "name": "Europe/London",
    "offset": 0,
    "offset_with_dst": 0,
    "date": "2025-12-24",
    "date_time": "2025-12-24 10:46:56",
    "date_time_txt": "Wednesday, December 24, 2025 10:46:56",
    "date_time_wti": "Wed, 24 Dec 2025 10:46:56 +0000",
    "date_time_ymd": "2025-12-24 10:46:56 +0000",
    "date_time_unix": 1766573216.682,
    "time_24": "10:46:56",
    "time_12": "10:46:56 AM",
    "week": 52,
    "month": 12,
    "year": 2025,
    "year_abbr": "25",
    "is_dst": false,
    "dst_savings": 0,
    "dst_exists": true,
    "dst_start": {
      "utc_time": "2025-03-30 TIME 01",
      "duration": "+1H",
      "gap": true,
      "date_time_after": "2025-03-30 TIME 02",
      "date_time_before": "2025-03-30 TIME 01",
      "overlap": false
    },
    "dst_end": {
      "utc_time": "2025-10-26 TIME 01",
      "duration": "-1H",
      "gap": false,
      "date_time_after": "2025-10-26 TIME 01",
      "date_time_before": "2025-10-26 TIME 02",
      "overlap": true
    }
  }
}
```
### Get Timezone from Any Address

```ruby
time_zone_opts = {
    location: "Munich, Germany"
}
time_zone_instance = IpgeolocationSdk::TimezoneApi.new
begin 
    result = time_zone_instance.get_timezone_info(time_zone_opts)
    puts result.to_hash.to_json
rescue IpgeolocationSdk::ApiError => e
    puts "Error calling TimezoneApi: #{e}"
end
```
Sample Response
```json
{
  "location": {
    "location_string": "Munich, Germany",
    "country_name": "Germany",
    "state_prov": "Bavaria",
    "city": "Munich",
    "locality": "",
    "latitude": "48.13711",
    "longitude": "11.57538"
  },
  "time_zone": {
    "name": "Europe/Berlin",
    "offset": 1,
    "offset_with_dst": 1,
    "date": "2025-12-24",
    "date_time": "2025-12-24 11:47:59",
    "date_time_txt": "Wednesday, December 24, 2025 11:47:59",
    "date_time_wti": "Wed, 24 Dec 2025 11:47:59 +0100",
    "date_time_ymd": "2025-12-24 11:47:59 +0100",
    "date_time_unix": 1766573279.493,
    "time_24": "11:47:59",
    "time_12": "11:47:59 AM",
    "week": 52,
    "month": 12,
    "year": 2025,
    "year_abbr": "25",
    "is_dst": false,
    "dst_savings": 0,
    "dst_exists": true,
    "dst_start": {
      "utc_time": "2025-03-30 TIME 01",
      "duration": "+1H",
      "gap": true,
      "date_time_after": "2025-03-30 TIME 03",
      "date_time_before": "2025-03-30 TIME 02",
      "overlap": false
    },
    "dst_end": {
      "utc_time": "2025-10-26 TIME 01",
      "duration": "-1H",
      "gap": false,
      "date_time_after": "2025-10-26 TIME 02",
      "date_time_before": "2025-10-26 TIME 03",
      "overlap": true
    }
  }
}
```
### Get Timezone from Location Coordinates

```ruby
time_zone_opts = {
    lat: 48.13711,
    long: 11.57538
}
time_zone_instance = IpgeolocationSdk::TimezoneApi.new
begin 
    result = time_zone_instance.get_timezone_info(time_zone_opts)
    puts result.to_hash.to_json
rescue IpgeolocationSdk::ApiError => e
    puts "Error calling TimezoneApi: #{e}"
end
```
Sample Response
```json
{
  "time_zone": {
    "name": "Europe/Berlin",
    "offset": 1,
    "offset_with_dst": 1,
    "date": "2025-12-24",
    "date_time": "2025-12-24 11:48:52",
    "date_time_txt": "Wednesday, December 24, 2025 11:48:52",
    "date_time_wti": "Wed, 24 Dec 2025 11:48:52 +0100",
    "date_time_ymd": "2025-12-24 11:48:52 +0100",
    "date_time_unix": 1766573332.887,
    "time_24": "11:48:52",
    "time_12": "11:48:52 AM",
    "week": 52,
    "month": 12,
    "year": 2025,
    "year_abbr": "25",
    "is_dst": false,
    "dst_savings": 0,
    "dst_exists": true,
    "dst_start": {
      "utc_time": "2025-03-30 TIME 01",
      "duration": "+1H",
      "gap": true,
      "date_time_after": "2025-03-30 TIME 03",
      "date_time_before": "2025-03-30 TIME 02",
      "overlap": false
    },
    "dst_end": {
      "utc_time": "2025-10-26 TIME 01",
      "duration": "-1H",
      "gap": false,
      "date_time_after": "2025-10-26 TIME 02",
      "date_time_before": "2025-10-26 TIME 03",
      "overlap": true
    }
  }
}
```
### Get Timezone and Airport Details from IATA Code

```ruby
time_zone_opts = {
    iata_code: "ZRH"
}
time_zone_instance = IpgeolocationSdk::TimezoneApi.new
begin 
    result = time_zone_instance.get_timezone_info(time_zone_opts)
    puts result.to_hash.to_json
rescue IpgeolocationSdk::ApiError => e
    puts "Error calling TimezoneApi: #{e}"
end
```
Sample Response
```json
{
  "airport_details": {
    "type": "large_airport",
    "name": "Zurich Airport",
    "latitude": "47.45806",
    "longitude": "8.54806",
    "elevation_ft": 1417,
    "continent_code": "EU",
    "country_code": "CH",
    "state_code": "CH-ZH",
    "city": "Zurich",
    "iata_code": "ZRH",
    "icao_code": "LSZH",
    "faa_code": ""
  },
  "time_zone": {
    "name": "Europe/Zurich",
    "offset": 1,
    "offset_with_dst": 1,
    "date": "2025-12-24",
    "date_time": "2025-12-24 11:49:56",
    "date_time_txt": "Wednesday, December 24, 2025 11:49:56",
    "date_time_wti": "Wed, 24 Dec 2025 11:49:56 +0100",
    "date_time_ymd": "2025-12-24 11:49:56 +0100",
    "date_time_unix": 1766573396.338,
    "time_24": "11:49:56",
    "time_12": "11:49:56 AM",
    "week": 52,
    "month": 12,
    "year": 2025,
    "year_abbr": "25",
    "is_dst": false,
    "dst_savings": 0,
    "dst_exists": true,
    "dst_start": {
      "utc_time": "2025-03-30 TIME 01",
      "duration": "+1H",
      "gap": true,
      "date_time_after": "2025-03-30 TIME 03",
      "date_time_before": "2025-03-30 TIME 02",
      "overlap": false
    },
    "dst_end": {
      "utc_time": "2025-10-26 TIME 01",
      "duration": "-1H",
      "gap": false,
      "date_time_after": "2025-10-26 TIME 02",
      "date_time_before": "2025-10-26 TIME 03",
      "overlap": true
    }
  }
}
```
Similarly, you can fetch Airport Details and Timezone from using any ICAO code (`icao_code`) as well.

### Get Timezone and City Details from UN/LOCODE

```ruby
time_zone_opts = {
    lo_code: "ESBCN"
}
time_zone_instance = IpgeolocationSdk::TimezoneApi.new
begin 
    result = time_zone_instance.get_timezone_info(time_zone_opts)
    puts result.to_hash.to_json
rescue IpgeolocationSdk::ApiError => e
    puts "Error calling TimezoneApi: #{e}"
end
```
Sample Response
```json
{
  "lo_code_details": {
    "lo_code": "ESBCN",
    "city": "Barcelona",
    "state_code": "",
    "country_code": "ES",
    "country_name": "",
    "location_type": "Port, Rail Terminal, Road Terminal, Airport, Postal Exchange",
    "latitude": "41.38289",
    "longitude": "2.17743"
  },
  "time_zone": {
    "name": "Europe/Madrid",
    "offset": 1,
    "offset_with_dst": 1,
    "date": "2025-12-24",
    "date_time": "2025-12-24 11:51:22",
    "date_time_txt": "Wednesday, December 24, 2025 11:51:22",
    "date_time_wti": "Wed, 24 Dec 2025 11:51:22 +0100",
    "date_time_ymd": "2025-12-24 11:51:22 +0100",
    "date_time_unix": 1766573482.037,
    "time_24": "11:51:22",
    "time_12": "11:51:22 AM",
    "week": 52,
    "month": 12,
    "year": 2025,
    "year_abbr": "25",
    "is_dst": false,
    "dst_savings": 0,
    "dst_exists": true,
    "dst_start": {
      "utc_time": "2025-03-30 TIME 01",
      "duration": "+1H",
      "gap": true,
      "date_time_after": "2025-03-30 TIME 03",
      "date_time_before": "2025-03-30 TIME 02",
      "overlap": false
    },
    "dst_end": {
      "utc_time": "2025-10-26 TIME 01",
      "duration": "-1H",
      "gap": false,
      "date_time_after": "2025-10-26 TIME 02",
      "date_time_before": "2025-10-26 TIME 03",
      "overlap": true
    }
  }
}
```

## Timezone Converter Examples

This section provides usage examples of the `convert_time_between_timezones()` method from the SDK. The Timezone Converter API allows you to convert a specific time from one timezone to another using timezone identifiers and optional date/time inputs.

For more details, refer to official documentation: [Timezone Converter API](https://ipgeolocation.io/documentation/timezone-api.html#convert-time-between-time-zones).

### Convert Current Time from One Timezone to Another

```ruby
time_conversion_opts = {
    tz_to: 'Asia/Tokyo',
    tz_from: 'America/New_York',
    # lat_from: 24.8607,
    # long_from: 67.0011,
    # lat_to: 40.7128,
    # long_to: -74.0060,
    # location_from: 'Karachi',
    # location_to: 'New York',
    # icao_from: 'OPKC',
    # icao_to: 'KJFK',
    # iata_from: 'KHI',
    # iata_to: 'JFK',
    # locode_from: 'PKKHI',
    # locode_to: 'USNYC'
}
time_conversion_instance = IpgeolocationSdk::TimeConversionApi.new
begin
  result = time_conversion_instance.convert_time_between_timezones(time_conversion_opts)
  puts result.to_hash.to_json
rescue IpgeolocationSdk::ApiError => e
  puts "Error calling TimeConversionApi: #{e}"
end
```
Sample Response
```json
{
  "original_time": "2025-12-24 05:52:21 +0500",
  "converted_time": "2025-12-24 19:52:21 +0500",
  "diff_hour": 14.0,
  "diff_min": 840
}
```
Similarly, you can convert time from any timezone to another timezone using location coordinates (Latitude and Longitude), location addresses, IATA codes, ICAO codes and UN/LOCODE.

## User Agent API Examples

This section provides usage examples of the `get_user_agent_details()` method from the SDK. The User Agent API extracts and classifies information from user agent strings, including browser, engine, device, OS, and type metadata.

For full explanation, visit the [User Agent API documentation](https://ipgeolocation.io/documentation/user-agent-api.html).

### Parse a Basic User Agent String

```ruby
get_user_agent_opts = {
    user_agent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/237.84.2.178 Safari/537.36'
}
user_agent_instance = IpgeolocationSdk::UserAgentApi.new
begin
    result = user_agent_instance.get_user_agent_details(get_user_agent_opts)
    puts result.to_hash.to_json
rescue IpgeolocationSdk::ApiError => e
    puts "Error calling UserAgentApi: #{e}"
end
```
Sample Response
```json
{
  "user_agent_string": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/237.84.2.178 Safari/537.36",
  "name": "Chrome",
  "type": "Browser",
  "version": "237.84.2.178",
  "version_major": "237",
  "device": {
    "name": "Desktop",
    "type": "Desktop",
    "brand": "Unknown",
    "cpu": "Intel x86_64"
  },
  "engine": {
    "name": "Blink",
    "type": "Browser",
    "version": "237.84",
    "version_major": "237"
  },
  "operating_system": {
    "name": "Windows NT",
    "type": "Desktop",
    "version": ">=10",
    "version_major": ">=10",
    "build": "??"
  }
}
```
If you don't pass any userAgentString, the API will return the data of device's user agent.

### Bulk User Agent Parsing Example

The SDK also supports bulk User Agent parsing using the `parse_bulk_user_agent_strings()` method. This allows parsing multiple user agent strings in a single request. All fields available in single-user-agent parsing are returned per entry.

```ruby
post_user_agent_opts = {
  user_agents: [
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/237.84.2.178 Safari/537.36",
    "Mozilla/5.0 (Linux; U; en-US) AppleWebKit/528.5+ (KHTML, like Gecko, Safari/528.5+) Version/4.0 Kindle/3.0 (screen 600x800; rotate)"
  ]
}
user_agent_instance = IpgeolocationSdk::UserAgentApi.new
begin
  result = user_agent_instance.parse_bulk_user_agent_strings(post_user_agent_opts)
  result.each do |item|
    puts item.to_hash.to_json
  end
rescue IpgeolocationSdk::ApiError => e
  puts "Error calling UserAgentApi: #{e}"
end
```

## Astronomy API Examples

This section provides usage examples of the `get_astronomy_details()` method from the SDK, allowing developers to fetch sun and moon timings and position data based on coordinates, IP, or location string.

Refer to the [official Astronomy API documentation](https://ipgeolocation.io/documentation/astronomy-api.html) for more details.

### Lookup Astronomy API by Coordinates

```ruby
get_astronomy_opts = {
    lat: "40.7128",
    long: "-74.0060"
}
astronomy_instance = IpgeolocationSdk::AstronomyApi.new
begin 
    result = astronomy_instance.get_astronomy_details(get_astronomy_opts)
    puts result.to_hash.to_json
rescue IpgeolocationSdk::ApiError => e
    puts "Error calling AstronomyApi: #{e}"
end
```
Sample Response
```json
{
  "location": {
    "country_name": "United States",
    "state_prov": "New York",
    "city": "New York City",
    "locality": "",
    "latitude": "40.71280",
    "longitude": "-74.00600",
    "elevation": "6"
  },
  "astronomy": {
    "date": "2025-12-24",
    "current_time": "07:56:54.527",
    "mid_night": "23:56",
    "night_end": "05:39",
    "morning": {
      "astronomical_twilight_begin": "05:39",
      "astronomical_twilight_end": "06:12",
      "nautical_twilight_begin": "06:12",
      "nautical_twilight_end": "06:47",
      "civil_twilight_begin": "06:47",
      "civil_twilight_end": "07:17",
      "blue_hour_begin": "06:35",
      "blue_hour_end": "06:58",
      "golden_hour_begin": "06:58",
      "golden_hour_end": "08:01"
    },
    "sunrise": "07:17",
    "sunset": "16:34",
    "evening": {
      "golden_hour_begin": "15:50",
      "golden_hour_end": "16:52",
      "blue_hour_begin": "16:52",
      "blue_hour_end": "17:16",
      "civil_twilight_begin": "16:34",
      "civil_twilight_end": "17:04",
      "nautical_twilight_begin": "17:04",
      "nautical_twilight_end": "17:39",
      "astronomical_twilight_begin": "17:39",
      "astronomical_twilight_end": "18:12"
    },
    "night_begin": "18:12",
    "sun_status": "-",
    "solar_noon": "11:55",
    "day_length": "09:16",
    "sun_altitude": 5.265772362659565,
    "sun_distance": 147152401.29833597,
    "sun_azimuth": 127.26720409145577,
    "moon_phase": "WAXING_CRESCENT",
    "moonrise": "10:24",
    "moonset": "21:09",
    "moon_status": "-",
    "moon_altitude": -27.021042229442685,
    "moon_distance": 390396.0648657473,
    "moon_azimuth": 87.02257245596411,
    "moon_parallactic_angle": -51.64698459434443,
    "moon_illumination_percentage": "18.22",
    "moon_angle": 50.53259996734376
  }
}
```

### Lookup Astronomy API by IP Address
```ruby
get_astronomy_opts = {
    ip: "8.8.8.8"
}
astronomy_instance = IpgeolocationSdk::AstronomyApi.new
begin 
    result = astronomy_instance.get_astronomy_details(get_astronomy_opts)
    puts result.to_hash.to_json
rescue IpgeolocationSdk::ApiError => e
    puts "Error calling AstronomyApi: #{e}"
end
```
Sample Response
```json
{
  "ip": "8.8.8.8",
  "location": {
    "continent_code": "NA",
    "continent_name": "North America",
    "country_code2": "US",
    "country_code3": "USA",
    "country_name": "United States",
    "country_name_official": "United States of America",
    "is_eu": false,
    "state_prov": "California",
    "state_code": "US-CA",
    "district": "Santa Clara",
    "city": "Mountain View",
    "locality": "Charleston Terrace",
    "zipcode": "94043-1351",
    "latitude": "37.42240",
    "longitude": "-122.08421",
    "elevation": "3"
  },
  "astronomy": {
    "date": "2025-12-24",
    "current_time": "04:58:05.179",
    "mid_night": "00:07",
    "night_end": "05:46",
    "morning": {
      "astronomical_twilight_begin": "05:46",
      "astronomical_twilight_end": "06:18",
      "nautical_twilight_begin": "06:18",
      "nautical_twilight_end": "06:51",
      "civil_twilight_begin": "06:51",
      "civil_twilight_end": "07:20",
      "blue_hour_begin": "06:40",
      "blue_hour_end": "07:02",
      "golden_hour_begin": "07:02",
      "golden_hour_end": "08:01"
    },
    "sunrise": "07:20",
    "sunset": "16:56",
    "evening": {
      "golden_hour_begin": "16:15",
      "golden_hour_end": "17:13",
      "blue_hour_begin": "17:13",
      "blue_hour_end": "17:36",
      "civil_twilight_begin": "16:56",
      "civil_twilight_end": "17:25",
      "nautical_twilight_begin": "17:25",
      "nautical_twilight_end": "17:57",
      "astronomical_twilight_begin": "17:57",
      "astronomical_twilight_end": "18:29"
    },
    "night_begin": "18:29",
    "sun_status": "-",
    "solar_noon": "12:08",
    "day_length": "09:35",
    "sun_altitude": -27.417802893936713,
    "sun_distance": 147152401.298336,
    "sun_azimuth": 99.58317083105555,
    "moon_phase": "WAXING_CRESCENT",
    "moonrise": "10:34",
    "moonset": "21:35",
    "moon_status": "-",
    "moon_altitude": -61.87418215314708,
    "moon_distance": 390392.88359927345,
    "moon_azimuth": 42.79081112532475,
    "moon_parallactic_angle": -33.98006664201916,
    "moon_illumination_percentage": "18.22",
    "moon_angle": 50.54213695165953
  }
}
```

### Lookup Astronomy API by Location String
```ruby
get_astronomy_opts = {
    location: "Milan, Italy"
}
astronomy_instance = IpgeolocationSdk::AstronomyApi.new
begin 
    result = astronomy_instance.get_astronomy_details(get_astronomy_opts)
    puts result.to_hash.to_json
rescue IpgeolocationSdk::ApiError => e
    puts "Error calling AstronomyApi: #{e}"
end
```
Sample Response
```json
{
  "location": {
    "location_string": "Milan, Italy",
    "country_name": "Italy",
    "state_prov": "Lombardy",
    "city": "Milan",
    "locality": "",
    "latitude": "45.46419",
    "longitude": "9.18963",
    "elevation": "122"
  },
  "astronomy": {
    "date": "2025-12-24",
    "current_time": "13:59:22.914",
    "mid_night": "00:22",
    "night_end": "06:13",
    "morning": {
      "astronomical_twilight_begin": "06:13",
      "astronomical_twilight_end": "06:49",
      "nautical_twilight_begin": "06:49",
      "nautical_twilight_end": "07:27",
      "civil_twilight_begin": "07:27",
      "civil_twilight_end": "07:59",
      "blue_hour_begin": "07:14",
      "blue_hour_end": "07:40",
      "golden_hour_begin": "07:40",
      "golden_hour_end": "08:51"
    },
    "sunrise": "07:59",
    "sunset": "16:47",
    "evening": {
      "golden_hour_begin": "15:54",
      "golden_hour_end": "17:05",
      "blue_hour_begin": "17:05",
      "blue_hour_end": "17:31",
      "civil_twilight_begin": "16:47",
      "civil_twilight_end": "17:18",
      "nautical_twilight_begin": "17:18",
      "nautical_twilight_end": "17:56",
      "astronomical_twilight_begin": "17:56",
      "astronomical_twilight_end": "18:32"
    },
    "night_begin": "18:32",
    "sun_status": "-",
    "solar_noon": "12:22",
    "day_length": "08:47",
    "sun_altitude": 17.723499498755025,
    "sun_distance": 147152401.298336,
    "sun_azimuth": 203.16933384107605,
    "moon_phase": "WAXING_CRESCENT",
    "moonrise": "10:55",
    "moonset": "21:13",
    "moon_status": "-",
    "moon_altitude": 23.979142365657644,
    "moon_distance": 390389.38303958566,
    "moon_azimuth": 149.16011529114445,
    "moon_parallactic_angle": -21.867682703140048,
    "moon_illumination_percentage": "18.23",
    "moon_angle": 50.55263020105739
  }
}
```
### Lookup Astronomy API for a Specific Date
```ruby
get_astronomy_opts = {
    date: "2025-01-01",
    lat: "-27.47000",
    long: "153.02000"
}
astronomy_instance = IpgeolocationSdk::AstronomyApi.new
begin 
    result = astronomy_instance.get_astronomy_details(get_astronomy_opts)
    puts result.to_hash.to_json
rescue IpgeolocationSdk::ApiError => e
    puts "Error calling AstronomyApi: #{e}"
end
```
Sample Response
```json
{
  "location": {
    "country_name": "Australia",
    "state_prov": "Queensland",
    "city": "Brisbane",
    "locality": "Brisbane",
    "latitude": "-27.47000",
    "longitude": "153.02000",
    "elevation": ""
  },
  "astronomy": {
    "date": "2025-01-01",
    "current_time": "23:00:08.526",
    "mid_night": "23:51",
    "night_end": "03:24",
    "morning": {
      "astronomical_twilight_begin": "03:24",
      "astronomical_twilight_end": "03:57",
      "nautical_twilight_begin": "03:57",
      "nautical_twilight_end": "04:29",
      "civil_twilight_begin": "04:29",
      "civil_twilight_end": "04:56",
      "blue_hour_begin": "04:19",
      "blue_hour_end": "04:40",
      "golden_hour_begin": "04:40",
      "golden_hour_end": "05:30"
    },
    "sunrise": "04:56",
    "sunset": "18:46",
    "evening": {
      "golden_hour_begin": "18:12",
      "golden_hour_end": "19:02",
      "blue_hour_begin": "19:02",
      "blue_hour_end": "19:23",
      "civil_twilight_begin": "18:46",
      "civil_twilight_end": "19:13",
      "nautical_twilight_begin": "19:13",
      "nautical_twilight_end": "19:45",
      "astronomical_twilight_begin": "19:45",
      "astronomical_twilight_end": "20:18"
    },
    "night_begin": "20:18",
    "sun_status": "-",
    "solar_noon": "11:51",
    "day_length": "13:50",
    "sun_altitude": -38.0693479495629,
    "sun_distance": 147102938.88036567,
    "sun_azimuth": 195.11207186624287,
    "moon_phase": "NEW_MOON",
    "moonrise": "05:42",
    "moonset": "20:08",
    "moon_status": "-",
    "moon_altitude": -28.36071812453645,
    "moon_distance": 380161.8657228659,
    "moon_azimuth": 216.5169650698993,
    "moon_parallactic_angle": 144.6623797008263,
    "moon_illumination_percentage": "2.97",
    "moon_angle": 19.851650971629937
  }
}
```

### Lookup Location info in Different Language
You can also get Astronomy Data in other languages as well. Only paid subscriptions can access this feature.
```ruby
get_astronomy_opts = {
    ip: "1.1.1.1",
    lang: "fr"
}
astronomy_instance = IpgeolocationSdk::AstronomyApi.new
begin 
    result = astronomy_instance.get_astronomy_details(get_astronomy_opts)
    puts result.to_hash.to_json
rescue IpgeolocationSdk::ApiError => e
    puts "Error calling AstronomyApi: #{e}"
end
```
Sample Response
```json
{
  "ip": "1.1.1.1",
  "location": {
    "continent_code": "AS",
    "continent_name": "Asie",
    "country_code2": "HK",
    "country_code3": "HKG",
    "country_name": "Hong Kong",
    "country_name_official": "",
    "is_eu": false,
    "state_prov": "Hong Kong Island",
    "state_code": "",
    "district": "",
    "city": "Hong Kong",
    "locality": "Soho",
    "zipcode": "",
    "latitude": "22.27683",
    "longitude": "114.17612",
    "elevation": ""
  },
  "astronomy": {
    "date": "2025-12-24",
    "mid_night": "00:22",
    "...": "...",
    "moon_angle": 50.57019974247744
  }
}
```

## Documentation for Models

- [IpgeolocationSdk::ASNConnection](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/ASNConnection.md)
- [IpgeolocationSdk::ASNResponse](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/ASNResponse.md)
- [IpgeolocationSdk::ASNDetails](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/ASNDetails.md)
- [IpgeolocationSdk::Abuse](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/Abuse.md)
- [IpgeolocationSdk::AbuseResponse](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/AbuseResponse.md)
- [IpgeolocationSdk::Astronomy](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/Astronomy.md)
- [IpgeolocationSdk::AstronomyEvening](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/AstronomyEvening.md)
- [IpgeolocationSdk::AstronomyLocation](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/AstronomyLocation.md)
- [IpgeolocationSdk::AstronomyMorning](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/AstronomyMorning.md)
- [IpgeolocationSdk::AstronomyResponse](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/AstronomyResponse.md)
- [IpgeolocationSdk::CountryMetadata](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/CountryMetadata.md)
- [IpgeolocationSdk::Currency](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/Currency.md)
- [IpgeolocationSdk::ErrorResponse](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/ErrorResponse.md)
- [IpgeolocationSdk::GeolocationResponse](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/GeolocationResponse.md)
- [IpgeolocationSdk::BulkIPGeolocation](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/BulkIPGeolocation.md)
- [IpgeolocationSdk::BulkIPSecurity](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/BulkIPSecurity.md)
- [IpgeolocationSdk::Location](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/Location.md)
- [IpgeolocationSdk::LocationMinimal](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/LocationMinimal.md)
- [IpgeolocationSdk::Network](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/Network.md)
- [IpgeolocationSdk::NetworkAsn](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/NetworkAsn.md)
- [IpgeolocationSdk::NetworkCompany](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/NetworkCompany.md)
- [IpgeolocationSdk::NetworkMinimal](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/NetworkMinimal.md)
- [IpgeolocationSdk::NetworkMinimalAsn](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/NetworkMinimalAsn.md)
- [IpgeolocationSdk::NetworkMinimalCompany](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/NetworkMinimalCompany.md)
- [IpgeolocationSdk::ParseBulkUserAgentStringsRequest](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/ParseBulkUserAgentStringsRequest.md)
- [IpgeolocationSdk::Security](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/Security.md)
- [IpgeolocationSdk::SecurityAPIResponse](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/SecurityAPIResponse.md)
- [IpgeolocationSdk::TimeConversionResponse](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/TimeConversionResponse.md)
- [IpgeolocationSdk::TimeZone](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/TimeZone.md)
- [IpgeolocationSdk::TimeZoneDetailedResponse](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/TimeZoneDetailedResponse.md)
- [IpgeolocationSdk::TimeZoneDstEnd](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/TimeZoneDstEnd.md)
- [IpgeolocationSdk::TimeZoneDstStart](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/TimeZoneDstStart.md)
- [IpgeolocationSdk::TimezoneAirport](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/TimezoneAirport.md)
- [IpgeolocationSdk::TimezoneDetail](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/TimezoneDetail.md)
- [IpgeolocationSdk::TimezoneDetailDstEnd](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/TimezoneDetailDstEnd.md)
- [IpgeolocationSdk::TimezoneDetailDstStart](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/TimezoneDetailDstStart.md)
- [IpgeolocationSdk::TimezoneLocation](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/TimezoneLocation.md)
- [IpgeolocationSdk::TimezoneLocode](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/TimezoneLocode.md)
- [IpgeolocationSdk::UserAgentData](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/UserAgentData.md)
- [IpgeolocationSdk::UserAgentDataDevice](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/UserAgentDataDevice.md)
- [IpgeolocationSdk::UserAgentDataEngine](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/UserAgentDataEngine.md)
- [IpgeolocationSdk::UserAgentDataOperatingSystem](https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/HEAD/docs/UserAgentDataOperatingSystem.md)

