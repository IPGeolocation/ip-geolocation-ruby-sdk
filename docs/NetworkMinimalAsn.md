# IpgeolocationSdk::NetworkMinimalAsn

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **as_number** | **String** |  | [optional] |
| **organization** | **String** |  | [optional] |
| **country** | **String** |  | [optional] |

## Example

```ruby
require 'ipgeolocation_sdk'

instance = IpgeolocationSdk::NetworkMinimalAsn.new(
  as_number: AS15169,
  organization: Google LLC,
  country: US
)
```

