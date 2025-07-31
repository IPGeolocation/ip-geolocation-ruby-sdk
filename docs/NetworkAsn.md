# IpgeolocationSdk::NetworkAsn

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **as_number** | **String** |  | [optional] |
| **organization** | **String** |  | [optional] |
| **country** | **String** |  | [optional] |
| **asn_name** | **String** |  | [optional] |
| **type** | **String** |  | [optional] |
| **domain** | **String** |  | [optional] |
| **date_allocated** | **String** |  | [optional] |
| **allocation_status** | **String** |  | [optional] |
| **num_of_ipv4_routes** | **String** |  | [optional] |
| **num_of_ipv6_routes** | **String** |  | [optional] |
| **rir** | **String** |  | [optional] |

## Example

```ruby
require 'ipgeolocation_sdk'

instance = IpgeolocationSdk::NetworkAsn.new(
  as_number: AS15169,
  organization: Google LLC,
  country: US,
  asn_name: GOOGLE,
  type: isp,
  domain: about.google,
  date_allocated: ,
  allocation_status: Assigned,
  num_of_ipv4_routes: 1099,
  num_of_ipv6_routes: 107,
  rir: ARIN
)
```

