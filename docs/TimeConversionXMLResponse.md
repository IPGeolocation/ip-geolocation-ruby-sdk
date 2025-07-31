# IpgeolocationSdk::TimeConversionXMLResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **original_time** | **String** |  | [optional] |
| **converted_time** | **String** |  | [optional] |
| **diff_hour** | **Float** |  | [optional] |
| **diff_min** | **Integer** |  | [optional] |

## Example

```ruby
require 'ipgeolocation_sdk'

instance = IpgeolocationSdk::TimeConversionXMLResponse.new(
  original_time: 2024-12-08 11:00,
  converted_time: 2024-12-08 18:30:00,
  diff_hour: 7.5,
  diff_min: 450
)
```

