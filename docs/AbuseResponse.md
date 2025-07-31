# IpgeolocationSdk::AbuseResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **ip** | **String** |  | [optional] |
| **abuse** | [**Abuse**](Abuse.md) |  | [optional] |

## Example

```ruby
require 'ipgeolocation_sdk'

instance = IpgeolocationSdk::AbuseResponse.new(
  ip: 8.8.8.8,
  abuse: null
)
```

