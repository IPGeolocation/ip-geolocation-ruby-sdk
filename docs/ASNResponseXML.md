# IpgeolocationSdk::ASNResponseXML

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **ip** | **String** |  | [optional] |
| **asn** | [**ASNResponseXMLAsn**](ASNResponseXMLAsn.md) |  | [optional] |

## Example

```ruby
require 'ipgeolocation_sdk'

instance = IpgeolocationSdk::ASNResponseXML.new(
  ip: 81.73.154.79,
  asn: null
)
```

