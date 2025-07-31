# IpgeolocationSdk::AstronomyResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **ip** | **String** |  | [optional] |
| **location** | [**AstronomyLocation**](AstronomyLocation.md) |  | [optional] |
| **astronomy** | [**Astronomy**](Astronomy.md) |  | [optional] |

## Example

```ruby
require 'ipgeolocation_sdk'

instance = IpgeolocationSdk::AstronomyResponse.new(
  ip: 8.8.8.8,
  location: null,
  astronomy: null
)
```

