# IpgeolocationSdk::TimezoneAirport

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **type** | **String** |  | [optional] |
| **name** | **String** |  | [optional] |
| **latitude** | **String** |  | [optional] |
| **longitude** | **String** |  | [optional] |
| **elevation_ft** | **Integer** |  | [optional] |
| **continent_code** | **String** |  | [optional] |
| **country_code** | **String** |  | [optional] |
| **state_code** | **String** |  | [optional] |
| **city** | **String** |  | [optional] |
| **iata_code** | **String** |  | [optional] |
| **icao_code** | **String** |  | [optional] |
| **faa_code** | **String** |  | [optional] |

## Example

```ruby
require 'ipgeolocation_sdk'

instance = IpgeolocationSdk::TimezoneAirport.new(
  type: large_airport,
  name: Hartsfield Jackson Atlanta International Airport,
  latitude: 33.63670,
  longitude: -84.42810,
  elevation_ft: 1026,
  continent_code: NA,
  country_code: US,
  state_code: US-GA,
  city: Atlanta,
  iata_code: ATL,
  icao_code: KATL,
  faa_code: 
)
```

