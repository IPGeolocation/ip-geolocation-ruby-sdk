# IpgeolocationSdk::Network

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **asn** | [**NetworkAsn**](NetworkAsn.md) |  | [optional] |
| **connection_type** | **String** |  | [optional] |
| **company** | [**NetworkCompany**](NetworkCompany.md) |  | [optional] |

## Example

```ruby
require 'ipgeolocation_sdk'

instance = IpgeolocationSdk::Network.new(
  asn: null,
  connection_type: wired,
  company: null
)
```

