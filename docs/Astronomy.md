# IpgeolocationSdk::Astronomy

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **time_zone** | **String** |  | [optional] |
| **date** | **String** |  | [optional] |
| **current_time** | **String** |  | [optional] |
| **mid_night** | **String** |  | [optional] |
| **night_end** | **String** |  | [optional] |
| **morning** | [**AstronomyMorning**](AstronomyMorning.md) |  | [optional] |
| **sunrise** | **String** |  | [optional] |
| **sunset** | **String** |  | [optional] |
| **evening** | [**AstronomyEvening**](AstronomyEvening.md) |  | [optional] |
| **night_begin** | **String** |  | [optional] |
| **sun_status** | **String** |  | [optional] |
| **solar_noon** | **String** |  | [optional] |
| **day_length** | **String** |  | [optional] |
| **sun_altitude** | **Float** |  | [optional] |
| **sun_distance** | **Float** |  | [optional] |
| **sun_azimuth** | **Float** |  | [optional] |
| **moon_phase** | **String** |  | [optional] |
| **moonrise** | **String** |  | [optional] |
| **moonset** | **String** |  | [optional] |
| **moon_status** | **String** |  | [optional] |
| **moon_altitude** | **Float** |  | [optional] |
| **moon_distance** | **Float** |  | [optional] |
| **moon_azimuth** | **Float** |  | [optional] |
| **moon_parallactic_angle** | **Float** |  | [optional] |
| **moon_illumination_percentage** | **String** |  | [optional] |
| **moon_angle** | **Float** |  | [optional] |

## Example

```ruby
require 'ipgeolocation_sdk'

instance = IpgeolocationSdk::Astronomy.new(
  time_zone: America/Los_Angeles,
  date: 2025-07-17,
  current_time: 08:03:36.532,
  mid_night: 01:02,
  night_end: 03:40,
  morning: null,
  sunrise: 05:39,
  sunset: 20:24,
  evening: null,
  night_begin: 22:23,
  sun_status: -,
  solar_noon: 13:02,
  day_length: 14:45,
  sun_altitude: 24.957683470850487,
  sun_distance: 152059278.3394745,
  sun_azimuth: 82.93803947255543,
  moon_phase: LAST_QUARTER,
  moonrise: -:-,
  moonset: 13:04,
  moon_status: -,
  moon_altitude: 50.865120808868284,
  moon_distance: 371690.2207058187,
  moon_azimuth: 224.27457358894264,
  moon_parallactic_angle: 32.4113797557535,
  moon_illumination_percentage: -55.99,
  moon_angle: 263.11859022190265
)
```

