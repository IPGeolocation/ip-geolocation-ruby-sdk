# IpgeolocationSdk::SecurityAPIXMLResponseArray

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **ip** | **String** |  | [optional] |
| **hostname** | **String** |  | [optional] |
| **security** | [**Security**](Security.md) |  | [optional] |
| **location** | [**LocationMinimal**](LocationMinimal.md) |  | [optional] |
| **network** | [**NetworkMinimal**](NetworkMinimal.md) |  | [optional] |
| **time_zone** | [**TimeZone**](TimeZone.md) |  | [optional] |
| **user_agent** | [**UserAgentData**](UserAgentData.md) |  | [optional] |
| **country_metadata** | [**CountryMetadata**](CountryMetadata.md) |  | [optional] |
| **currency** | [**Currency**](Currency.md) |  | [optional] |

## Example

```ruby
require 'ipgeolocation_sdk'

instance = IpgeolocationSdk::SecurityAPIXMLResponseArray.new(
  ip: 8.8.8.8,
  hostname: 195-154-221-54.rev.poneytelecom.eu,
  security: null,
  location: null,
  network: null,
  time_zone: null,
  user_agent: null,
  country_metadata: null,
  currency: null
)
```

