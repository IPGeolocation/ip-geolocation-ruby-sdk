# IpgeolocationSdk::NetworkCompany

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **name** | **String** |  | [optional] |
| **type** | **String** |  | [optional] |
| **domain** | **String** |  | [optional] |

## Example

```ruby
require 'ipgeolocation_sdk'

instance = IpgeolocationSdk::NetworkCompany.new(
  name: Google LLC,
  type: hosting,
  domain: google.com
)
```

