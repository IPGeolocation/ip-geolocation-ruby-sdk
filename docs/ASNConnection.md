# IpgeolocationSdk::ASNConnection

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **as_number** | **String** |  | [optional] |
| **description** | **String** |  | [optional] |
| **country** | **String** |  | [optional] |

## Example

```ruby
require 'ipgeolocation_sdk'

instance = IpgeolocationSdk::ASNConnection.new(
  as_number: AS12779,
  description: IT.Gate S.p.A.,
  country: IT
)
```

