# IpgeolocationSdk::TimeZoneDetailedResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **ip** | **String** |  | [optional] |
| **airport_details** | [**TimezoneAirport**](TimezoneAirport.md) |  | [optional] |
| **lo_code_details** | [**TimezoneLocode**](TimezoneLocode.md) |  | [optional] |
| **location** | [**TimezoneLocation**](TimezoneLocation.md) |  | [optional] |
| **time_zone** | [**TimezoneDetail**](TimezoneDetail.md) |  | [optional] |

## Example

```ruby
require 'ipgeolocation_sdk'

instance = IpgeolocationSdk::TimeZoneDetailedResponse.new(
  ip: 8.8.8.8,
  airport_details: null,
  lo_code_details: null,
  location: null,
  time_zone: null
)
```

