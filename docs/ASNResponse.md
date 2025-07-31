# IpgeolocationSdk::ASNResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **ip** | **String** | IP address for which ASN information is returned. Present if the &#39;ip&#39; query parameter is used or no IP is specified (defaults to requester&#39;s IP). | [optional] |
| **asn** | [**ASNResponseAsn**](ASNResponseAsn.md) |  | [optional] |

## Example

```ruby
require 'ipgeolocation_sdk'

instance = IpgeolocationSdk::ASNResponse.new(
  ip: 81.73.154.79,
  asn: null
)
```

