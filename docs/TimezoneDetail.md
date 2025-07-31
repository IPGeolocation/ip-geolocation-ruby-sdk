# IpgeolocationSdk::TimezoneDetail

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **name** | **String** |  | [optional] |
| **offset** | **Integer** |  | [optional] |
| **offset_with_dst** | **Integer** |  | [optional] |
| **date** | **Date** |  | [optional] |
| **date_time** | **String** |  | [optional] |
| **date_time_txt** | **String** |  | [optional] |
| **date_time_wti** | **String** |  | [optional] |
| **date_time_ymd** | **Time** |  | [optional] |
| **date_time_unix** | **Float** |  | [optional] |
| **time_24** | **String** |  | [optional] |
| **time_12** | **String** |  | [optional] |
| **week** | **Integer** |  | [optional] |
| **month** | **Integer** |  | [optional] |
| **year** | **Integer** |  | [optional] |
| **year_abbr** | **String** |  | [optional] |
| **is_dst** | **Boolean** |  | [optional] |
| **dst_savings** | **Integer** |  | [optional] |
| **dst_exists** | **Boolean** |  | [optional] |
| **dst_start** | [**TimezoneDetailDstStart**](TimezoneDetailDstStart.md) |  | [optional] |
| **dst_end** | [**TimezoneDetailDstEnd**](TimezoneDetailDstEnd.md) |  | [optional] |

## Example

```ruby
require 'ipgeolocation_sdk'

instance = IpgeolocationSdk::TimezoneDetail.new(
  name: America/Los_Angeles,
  offset: -8,
  offset_with_dst: -7,
  date: Thu Apr 24 05:00:00 PKT 2025,
  date_time: 2025-04-24 11:30:12,
  date_time_txt: Thursday, April 24, 2025 11:30:12,
  date_time_wti: Thu, 24 Apr 2025 11:30:12 -0700,
  date_time_ymd: null,
  date_time_unix: 1745519412.353,
  time_24: 41412,
  time_12: 11:30:12 AM,
  week: 17,
  month: 4,
  year: 2025,
  year_abbr: 25,
  is_dst: null,
  dst_savings: null,
  dst_exists: null,
  dst_start: null,
  dst_end: null
)
```

