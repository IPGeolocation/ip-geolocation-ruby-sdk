# IpgeolocationSdk::TimeConversionResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **original_time** | **Time** |  | [optional] |
| **converted_time** | **Time** |  | [optional] |
| **diff_hour** | **Float** |  | [optional] |
| **diff_min** | **Integer** |  | [optional] |

## Example

```ruby
require 'ipgeolocation_sdk'

instance = IpgeolocationSdk::TimeConversionResponse.new(
  original_time: null,
  converted_time: null,
  diff_hour: 7.5,
  diff_min: 450
)
```

