# IPGeolocation Ruby SDK

Official Ruby SDK for the IPGeolocation.io IP Location API.

Look up IPv4, IPv6, and domains with `/v3/ipgeo` and `/v3/ipgeo-bulk`. Get geolocation, company, ASN, timezone, network, hostname, abuse, user-agent, and security data from one API.

- Ruby 2.7+
- Sync client built on `Net::HTTP`
- Typed responses plus raw JSON and XML methods

## Table of Contents

- [Install](#install)
- [Quick Start](#quick-start)
- [At a Glance](#at-a-glance)
- [Get Your API Key](#get-your-api-key)
- [Authentication](#authentication)
- [Plan Behavior](#plan-behavior)
- [Client Configuration](#client-configuration)
- [Available Methods](#available-methods)
- [Request Options](#request-options)
- [Examples](#examples)
- [Response Metadata](#response-metadata)
- [JSON Helpers](#json-helpers)
- [Errors](#errors)
- [Troubleshooting](#troubleshooting)
- [Frequently Asked Questions](#frequently-asked-questions)
- [Links](#links)

## Install

```bash
gem install ipgeolocation_sdk
```

Or add it to your `Gemfile`:

```ruby
gem "ipgeolocation_sdk", "~> 2.0"
```

Then run:

```bash
bundle install
```

```ruby
require "ipgeolocation_sdk"
```

RubyGems package: `ipgeolocation_sdk`  
Package page: <https://rubygems.org/gems/ipgeolocation_sdk>  
GitHub repository: <https://github.com/IPGeolocation/ip-geolocation-ruby-sdk>

## Quick Start

```ruby
require "ipgeolocation_sdk"

client = IpgeolocationSdk::IpGeolocationClient.new(
  api_key: ENV.fetch("IPGEO_API_KEY")
)

begin
  response = client.lookup_ip_geolocation(ip: "8.8.8.8")

  puts response.data.ip # 8.8.8.8
  puts response.data.location&.country_name # United States
  puts response.data.location&.city
  puts response.data.time_zone&.name
  puts response.metadata.credits_charged
ensure
  client.close
end
```

You can also pass `LookupIpGeolocationRequest` and `BulkLookupIpGeolocationRequest` objects if you want validation before the request is sent.

## At a Glance

| Item | Value |
|------|-------|
| Gem | `ipgeolocation_sdk` |
| Module | `IpgeolocationSdk` |
| Supported Endpoints | `/v3/ipgeo`, `/v3/ipgeo-bulk` |
| Supported Inputs | IPv4, IPv6, domain |
| Main Data Returned | Geolocation, company, ASN, timezone, network, hostname, abuse, user-agent, currency, security |
| Authentication | API key, request-origin auth for `/v3/ipgeo` only |
| Response Formats | Structured JSON, raw JSON, raw XML |
| Bulk Limit | Up to 50,000 IPs or domains per request |
| Transport | `Net::HTTP` |

## Get Your API Key

To use most SDK features, create or access your IPGeolocation account and copy an API key from your dashboard.

1. Sign up: <https://app.ipgeolocation.io/signup>
2. Verify your email if prompted
3. Sign in: <https://app.ipgeolocation.io/login>
4. Open your dashboard: <https://app.ipgeolocation.io/dashboard>
5. Copy an API key from the `API Keys` section

For server-side code, keep the API key in an environment variable or secret manager. For browser-based single lookups on paid plans, use request-origin auth instead of exposing an API key in frontend code.

## Authentication

### API Key

```ruby
client = IpgeolocationSdk::IpGeolocationClient.new(
  api_key: ENV.fetch("IPGEO_API_KEY")
)
```

### Request-Origin Auth

```ruby
client = IpgeolocationSdk::IpGeolocationClient.new(
  request_origin: "https://app.example.com"
)
```

`request_origin` must be an absolute `http` or `https` origin with no path, query string, fragment, or userinfo.

> [!IMPORTANT]
> Request-origin auth does not work with `/v3/ipgeo-bulk`. Bulk lookup always requires `api_key`.

> [!NOTE]
> If you set both `api_key` and `request_origin`, single lookup still uses the API key. The API key is sent as the `apiKey` query parameter, so avoid logging full request URLs.

## Plan Behavior

Feature availability depends on your plan and request parameters.

| Capability | Free | Paid |
|------------|------|------|
| Single IPv4 and IPv6 lookup | Supported | Supported |
| Domain lookup | Not supported | Supported |
| Bulk lookup | Not supported | Supported |
| Non-English `lang` | Not supported | Supported |
| Request-origin auth | Not supported | Supported for `/v3/ipgeo` only |
| Optional modules via `include` | Not supported | Supported |
| `include: ["*"]` | Base response only | All plan-available modules |

Paid plans still need `include` for optional modules. `fields` and `excludes` only trim the response. They do not turn modules on or unlock paid data.

## Client Configuration

| Field | Type | Default | Notes |
|-------|------|---------|-------|
| `api_key` | `String` | unset | Required for bulk lookup. Optional for single lookup if `request_origin` is set. |
| `request_origin` | `String` | unset | Must be an absolute `http` or `https` origin. |
| `base_url` | `String` | `https://api.ipgeolocation.io` | Override the API base URL. |
| `connect_timeout` | `Numeric` | `10.0` | Time to open the connection, in seconds. |
| `read_timeout` | `Numeric` | `30.0` | Time to wait while reading the response body, in seconds. |

The client constructor accepts either an `IpGeolocationClientConfig` or a hash with the same keys.

## Available Methods

| Method | Returns | Notes |
|--------|---------|-------|
| `lookup_ip_geolocation(request = nil)` | `ApiResponse` with typed `data` | Single lookup. Typed JSON response. |
| `lookup_ip_geolocation_raw(request = nil)` | `ApiResponse` with `String` `data` | Single lookup. Raw JSON or XML string. |
| `bulk_lookup_ip_geolocation(request)` | `ApiResponse` with bulk result array | Bulk lookup. Typed JSON response. |
| `bulk_lookup_ip_geolocation_raw(request)` | `ApiResponse` with `String` `data` | Bulk lookup. Raw JSON or XML string. |
| `close` | `nil` | Closes the client. Do not reuse the client after this. |

> [!NOTE]
> Typed methods support JSON only. Use the raw methods when you need XML output.

## Request Options

| Field | Applies To | Notes |
|-------|------------|-------|
| `ip` | Single lookup | IPv4, IPv6, or domain. Omit it for caller IP lookup. |
| `ips` | Bulk lookup | Array of 1 to 50,000 IPs or domains. |
| `lang` | Single and bulk | One of `en`, `de`, `ru`, `ja`, `fr`, `cn`, `es`, `cs`, `it`, `ko`, `fa`, `pt`. |
| `include` | Single and bulk | Array of module names such as `security`, `abuse`, `user_agent`, `hostname`, `liveHostname`, `hostnameFallbackLive`, `geo_accuracy`, `dma_code`, or `*`. |
| `fields` | Single and bulk | Array of field paths to keep, for example `["location.country_name", "security.threat_score"]`. |
| `excludes` | Single and bulk | Array of field paths to remove from the response. |
| `user_agent` | Single and bulk | Overrides the outbound `User-Agent` header. |
| `headers` | Single and bulk | Extra request headers. Use a hash where each value is a string or an array of strings. |
| `output` | Single and bulk | `"json"` or `"xml"`. Typed methods require JSON. |

## Examples

The examples below assume you already have a configured client in scope:

```ruby
client = IpgeolocationSdk::IpGeolocationClient.new(
  api_key: ENV.fetch("IPGEO_API_KEY")
)
```

### Caller IP

Omit `ip` to look up the public IP of the machine making the request.

```ruby
response = client.lookup_ip_geolocation
puts response.data.ip
```

### Domain Lookup

Domain lookup is a paid-plan feature.

```ruby
response = client.lookup_ip_geolocation(ip: "ipgeolocation.io")

puts response.data.ip
puts response.data.domain # ipgeolocation.io
puts response.data.location&.country_name
```

### Security and Abuse

```ruby
response = client.lookup_ip_geolocation(
  ip: "9.9.9.9",
  include: ["security", "abuse"]
)

puts response.data.security&.threat_score
puts response.data.abuse&.emails&.first
```

### User-Agent Parsing

To parse a visitor user-agent string, pass `include: ["user_agent"]` and send the visitor string in the request `User-Agent` header.

```ruby
visitor_ua = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/601.3.9 (KHTML, like Gecko) Version/9.0.2 Safari/601.3.9"

response = client.lookup_ip_geolocation(
  ip: "115.240.90.163",
  include: ["user_agent"],
  headers: { "User-Agent" => visitor_ua }
)

puts response.data.user_agent&.name
puts response.data.user_agent&.operating_system&.name
```

> [!NOTE]
> The `user_agent` request field overrides the SDK's default outbound `User-Agent` header. It takes precedence over `headers["User-Agent"]`.

### Filtered Response

```ruby
response = client.lookup_ip_geolocation(
  ip: "8.8.8.8",
  include: ["security"],
  fields: ["location.country_name", "security.threat_score", "security.is_vpn"],
  excludes: ["currency"]
)

puts response.data.location&.country_name
puts response.data.security&.threat_score
puts response.data.security&.is_vpn
```

### Raw XML

```ruby
response = client.lookup_ip_geolocation_raw(
  ip: "8.8.8.8",
  output: IpgeolocationSdk::ResponseFormat::XML
)

puts response.data
```

### Bulk Lookup

Bulk lookup is a paid-plan feature and always requires `api_key`.

Each bulk result is either a success or an error.

```ruby
response = client.bulk_lookup_ip_geolocation(
  ips: ["8.8.8.8", "invalid-ip", "1.1.1.1"],
  include: ["security"]
)

response.data.each do |result|
  if result.success?
    puts result.data.ip
    puts result.data.security&.threat_score
    next
  end

  puts result.error.message
end
```

## Response Metadata

Each method returns an `ApiResponse` with `data` and `metadata`.

`metadata` includes:

| Field | Meaning |
|-------|---------|
| `credits_charged` | Credits charged for the request when the API returns that header |
| `successful_records` | Number of successful bulk records when the API returns that header |
| `status_code` | HTTP status code |
| `duration_ms` | Client-side request time in milliseconds |
| `raw_headers` | Response headers as `Hash<String, Array<String>>` |

Helper methods:

```ruby
metadata = response.metadata

puts metadata.status_code
puts metadata.duration_ms
puts metadata.header_values("X-Credits-Charged").inspect
puts metadata.first_header_value("Content-Type")
```

## JSON Helpers

Use these helpers to turn SDK objects into JSON:

```ruby
puts IpgeolocationSdk.to_json(response.data)
puts IpgeolocationSdk.to_pretty_json(response.data)
puts IpgeolocationSdk.to_pretty_json(response.data, :full)
```

Compact mode omits `nil` fields. Full mode keeps them.

## Errors

The SDK raises these exception classes:

- `IpgeolocationSdk::ValidationError`
- `IpgeolocationSdk::SerializationError`
- `IpgeolocationSdk::TransportError`
- `IpgeolocationSdk::RequestTimeoutError`
- `IpgeolocationSdk::ApiError`
- `IpgeolocationSdk::BadRequestError`
- `IpgeolocationSdk::UnauthorizedError`
- `IpgeolocationSdk::NotFoundError`
- `IpgeolocationSdk::MethodNotAllowedError`
- `IpgeolocationSdk::PayloadTooLargeError`
- `IpgeolocationSdk::UnsupportedMediaTypeError`
- `IpgeolocationSdk::LockedError`
- `IpgeolocationSdk::RateLimitError`
- `IpgeolocationSdk::ClientClosedRequestError`
- `IpgeolocationSdk::ServerError`

Example:

```ruby
begin
  client.lookup_ip_geolocation(ip: "8.8.8.8")
rescue IpgeolocationSdk::ApiError => error
  puts error.status_code
  puts error.api_message
  puts error.message
end
```

## Troubleshooting

- `bulk lookup requires api_key in client config`
  Bulk lookup does not support request-origin auth on its own.
- `single lookup requires api_key or request_origin in client config`
  Set at least one authentication option before calling the single lookup methods.
- `XML output is not supported by typed methods`
  Use `lookup_ip_geolocation_raw` or `bulk_lookup_ip_geolocation_raw` for XML output.
- `client is closed`
  Create a new client after calling `close`.
- `TransportError` or `RequestTimeoutError`
  Increase `connect_timeout` or `read_timeout`, or add your own retry logic.

## Frequently Asked Questions

<details>
<summary><strong>Can I pass a plain hash instead of a request object?</strong></summary>
Yes. All client methods accept either the typed request object or a plain hash with the same keys.
</details>

<details>
<summary><strong>How do I look up my own public IP?</strong></summary>
Call <code>lookup_ip_geolocation</code> with no <code>ip</code> value.
</details>

<details>
<summary><strong>How do I get XML?</strong></summary>
Use the raw methods with <code>output: IpgeolocationSdk::ResponseFormat::XML</code>.
</details>

<details>
<summary><strong>How do I read bulk errors?</strong></summary>
Check <code>result.success?</code>. Success items use <code>result.data</code>. Error items use <code>result.error.message</code>.
</details>

## Links

- API docs: <https://ipgeolocation.io/documentation/ip-location-api.html>
- Dashboard: <https://app.ipgeolocation.io/dashboard>
- Pricing: <https://ipgeolocation.io/pricing.html>
- RubyGems package: <https://rubygems.org/gems/ipgeolocation_sdk>
- GitHub repo: <https://github.com/IPGeolocation/ip-geolocation-ruby-sdk>
