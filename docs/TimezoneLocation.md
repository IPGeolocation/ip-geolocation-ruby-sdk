# IpgeolocationSdk::TimezoneLocation

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **location_string** | **String** |  | [optional] |
| **continent_code** | **String** |  | [optional] |
| **continent_name** | **String** |  | [optional] |
| **country_code2** | **String** |  | [optional] |
| **country_code3** | **String** |  | [optional] |
| **country_name** | **String** |  | [optional] |
| **country_name_official** | **String** |  | [optional] |
| **is_eu** | **Boolean** |  | [optional] |
| **state_prov** | **String** |  | [optional] |
| **state_code** | **String** |  | [optional] |
| **district** | **String** |  | [optional] |
| **city** | **String** |  | [optional] |
| **locality** | **String** |  | [optional] |
| **zipcode** | **String** |  | [optional] |
| **latitude** | **String** |  | [optional] |
| **longitude** | **String** |  | [optional] |

## Example

```ruby
require 'ipgeolocation_sdk'

instance = IpgeolocationSdk::TimezoneLocation.new(
  location_string: Londong, UK,
  continent_code: OC,
  continent_name: Oceania,
  country_code2: AU,
  country_code3: AUS,
  country_name: Australia,
  country_name_official: Commonwealth of Australia,
  is_eu: false,
  state_prov: Queensland,
  state_code: AU-QLD,
  district: South Brisbane,
  city: Brisbane,
  locality: ,
  zipcode: 4101,
  latitude: -27.47306,
  longitude: 153.01421
)
```

