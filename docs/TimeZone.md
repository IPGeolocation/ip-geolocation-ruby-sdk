# IpgeolocationSdk::TimeZone

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **name** | **String** |  | [optional] |
| **offset** | **Integer** |  | [optional] |
| **offset_with_dst** | **Integer** |  | [optional] |
| **current_time** | **String** |  | [optional] |
| **current_time_unix** | **Float** |  | [optional] |
| **is_dst** | **Boolean** |  | [optional] |
| **dst_savings** | **Integer** |  | [optional] |
| **dst_exists** | **Boolean** |  | [optional] |
| **dst_start** | [**TimeZoneDstStart**](TimeZoneDstStart.md) |  | [optional] |
| **dst_end** | [**TimeZoneDstEnd**](TimeZoneDstEnd.md) |  | [optional] |

## Example

```ruby
require 'ipgeolocation_sdk'

instance = IpgeolocationSdk::TimeZone.new(
  name: America/Los_Angeles,
  offset: -8,
  offset_with_dst: -7,
  current_time: 2025-04-22 06:19:40.951-0700,
  current_time_unix: 1745327980.951,
  is_dst: true,
  dst_savings: 1,
  dst_exists: true,
  dst_start: null,
  dst_end: null
)
```

