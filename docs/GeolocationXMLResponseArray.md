# IpgeolocationSdk::GeolocationXMLResponseArray

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **ip** | **String** |  | [optional] |
| **hostname** | **String** |  | [optional] |
| **domain** | **String** |  | [optional] |
| **location** | [**Location**](Location.md) |  | [optional] |
| **country_metadata** | [**CountryMetadata**](CountryMetadata.md) |  | [optional] |
| **network** | [**Network**](Network.md) |  | [optional] |
| **currency** | [**Currency**](Currency.md) |  | [optional] |
| **security** | [**Security**](Security.md) |  | [optional] |
| **abuse** | [**Abuse**](Abuse.md) |  | [optional] |
| **time_zone** | [**TimeZone**](TimeZone.md) |  | [optional] |
| **user_agent** | [**UserAgentData**](UserAgentData.md) |  | [optional] |

## Example

```ruby
require 'ipgeolocation_sdk'

instance = IpgeolocationSdk::GeolocationXMLResponseArray.new(
  ip: 8.8.8.8,
  hostname: dns.google,
  domain: google.com,
  location: null,
  country_metadata: null,
  network: null,
  currency: null,
  security: null,
  abuse: null,
  time_zone: null,
  user_agent: null
)
```

