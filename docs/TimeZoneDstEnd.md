# IpgeolocationSdk::TimeZoneDstEnd

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **utc_time** | **String** |  | [optional] |
| **duration** | **String** |  | [optional] |
| **gap** | **Boolean** |  | [optional] |
| **date_time_after** | **String** |  | [optional] |
| **date_time_before** | **String** |  | [optional] |
| **overlap** | **Boolean** |  | [optional] |

## Example

```ruby
require 'ipgeolocation_sdk'

instance = IpgeolocationSdk::TimeZoneDstEnd.new(
  utc_time: 2025-11-02 TIME 09,
  duration: -1H,
  gap: false,
  date_time_after: 2025-11-02 TIME 01,
  date_time_before: 2025-11-02 TIME 02,
  overlap: true
)
```

