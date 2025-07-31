# IpgeolocationSdk::TimezoneDetailDstStart

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

instance = IpgeolocationSdk::TimezoneDetailDstStart.new(
  utc_time: 2025-03-09 TIME 10,
  duration: +1H,
  gap: null,
  date_time_after: 2025-03-09 TIME 03,
  date_time_before: 2025-03-09 TIME 02,
  overlap: null
)
```

