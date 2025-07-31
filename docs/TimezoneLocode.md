# IpgeolocationSdk::TimezoneLocode

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **lo_code** | **String** |  | [optional] |
| **city** | **String** |  | [optional] |
| **state_code** | **String** |  | [optional] |
| **country_code** | **String** |  | [optional] |
| **country_name** | **String** |  | [optional] |
| **location_type** | **String** |  | [optional] |
| **latitude** | **String** |  | [optional] |
| **longitude** | **String** |  | [optional] |

## Example

```ruby
require 'ipgeolocation_sdk'

instance = IpgeolocationSdk::TimezoneLocode.new(
  lo_code: DEBER,
  city: Berlin,
  state_code: BE,
  country_code: DE,
  country_name: ,
  location_type: Port, Rail Terminal, Road Terminal, Airport, Postal Exchange,
  latitude: 52.51667,
  longitude: 13.38333
)
```

