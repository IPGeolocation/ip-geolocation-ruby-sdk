# IpgeolocationSdk::LocationMinimal

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **continent_code** | **String** |  | [optional] |
| **continent_name** | **String** |  | [optional] |
| **country_code2** | **String** |  | [optional] |
| **country_code3** | **String** |  | [optional] |
| **country_name** | **String** |  | [optional] |
| **country_name_official** | **String** |  | [optional] |
| **country_capital** | **String** |  | [optional] |
| **state_prov** | **String** |  | [optional] |
| **state_code** | **String** |  | [optional] |
| **district** | **String** |  | [optional] |
| **city** | **String** |  | [optional] |
| **zipcode** | **String** |  | [optional] |
| **latitude** | **String** |  | [optional] |
| **longitude** | **String** |  | [optional] |
| **is_eu** | **Boolean** |  | [optional] |
| **country_flag** | **String** |  | [optional] |
| **geoname_id** | **String** |  | [optional] |
| **country_emoji** | **String** |  | [optional] |

## Example

```ruby
require 'ipgeolocation_sdk'

instance = IpgeolocationSdk::LocationMinimal.new(
  continent_code: NA,
  continent_name: North America,
  country_code2: US,
  country_code3: USA,
  country_name: United States,
  country_name_official: United States of America,
  country_capital: Washington, D.C.,
  state_prov: California,
  state_code: US-CA,
  district: Santa Clara,
  city: Mountain View,
  zipcode: 94043-1351,
  latitude: 37.42240,
  longitude: -122.08421,
  is_eu: false,
  country_flag: https://ipgeolocation.io/static/flags/us_64.png,
  geoname_id: 6301403,
  country_emoji: 
)
```

