# IpgeolocationSdk::Abuse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **route** | **String** |  | [optional] |
| **country** | **String** |  | [optional] |
| **handle** | **String** |  | [optional] |
| **name** | **String** |  | [optional] |
| **organization** | **String** |  | [optional] |
| **role** | **String** |  | [optional] |
| **kind** | **String** |  | [optional] |
| **address** | **String** |  | [optional] |
| **emails** | **Array&lt;String&gt;** |  | [optional] |
| **phone_numbers** | **Array&lt;String&gt;** |  | [optional] |

## Example

```ruby
require 'ipgeolocation_sdk'

instance = IpgeolocationSdk::Abuse.new(
  route: 8.8.8.0/24,
  country: US,
  handle: ABUSE5250-ARIN,
  name: Abuse,
  organization: Abuse,
  role: abuse,
  kind: group,
  address: 1600 Amphitheatre Parkway
Mountain View
CA
94043
United States,
  emails: [&quot;network-abuse@google.com&quot;],
  phone_numbers: [&quot;+1-650-253-0000&quot;]
)
```

