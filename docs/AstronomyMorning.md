# IpgeolocationSdk::AstronomyMorning

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **astronomical_twilight_begin** | **String** |  | [optional] |
| **astronomical_twilight_end** | **String** |  | [optional] |
| **nautical_twilight_begin** | **String** |  | [optional] |
| **nautical_twilight_end** | **String** |  | [optional] |
| **civil_twilight_begin** | **String** |  | [optional] |
| **civil_twilight_end** | **String** |  | [optional] |
| **blue_hour_begin** | **String** |  | [optional] |
| **blue_hour_end** | **String** |  | [optional] |
| **golden_hour_begin** | **String** |  | [optional] |
| **golden_hour_end** | **String** |  | [optional] |

## Example

```ruby
require 'ipgeolocation_sdk'

instance = IpgeolocationSdk::AstronomyMorning.new(
  astronomical_twilight_begin: 03:40,
  astronomical_twilight_end: 04:27,
  nautical_twilight_begin: 04:27,
  nautical_twilight_end: 05:07,
  civil_twilight_begin: 05:07,
  civil_twilight_end: 05:39,
  blue_hour_begin: 04:54,
  blue_hour_end: 05:20,
  golden_hour_begin: 05:20,
  golden_hour_end: 06:19
)
```

