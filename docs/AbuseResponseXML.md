# IpgeolocationSdk::AbuseResponseXML

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **ip** | **String** |  | [optional] |
| **abuse** | [**Abuse**](Abuse.md) |  | [optional] |

## Example

```ruby
require 'ipgeolocation_sdk'

instance = IpgeolocationSdk::AbuseResponseXML.new(
  ip: 8.8.8.8,
  abuse: null
)
```

