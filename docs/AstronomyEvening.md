# IpgeolocationSdk::AstronomyEvening

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **golden_hour_begin** | **String** |  | [optional] |
| **golden_hour_end** | **String** |  | [optional] |
| **blue_hour_begin** | **String** |  | [optional] |
| **blue_hour_end** | **String** |  | [optional] |
| **civil_twilight_begin** | **String** |  | [optional] |
| **civil_twilight_end** | **String** |  | [optional] |
| **nautical_twilight_begin** | **String** |  | [optional] |
| **nautical_twilight_end** | **String** |  | [optional] |
| **astronomical_twilight_begin** | **String** |  | [optional] |
| **astronomical_twilight_end** | **String** |  | [optional] |

## Example

```ruby
require 'ipgeolocation_sdk'

instance = IpgeolocationSdk::AstronomyEvening.new(
  golden_hour_begin: 19:44,
  golden_hour_end: 20:44,
  blue_hour_begin: 20:44,
  blue_hour_end: 21:09,
  civil_twilight_begin: 20:24,
  civil_twilight_end: 20:56,
  nautical_twilight_begin: 20:56,
  nautical_twilight_end: 21:37,
  astronomical_twilight_begin: 21:37,
  astronomical_twilight_end: 22:23
)
```

