# IpgeolocationSdk::GetBulkIpSecurityInfo200ResponseInner1

## Class instance methods

### `openapi_one_of`

Returns the list of classes defined in oneOf.

#### Example

```ruby
require 'ipgeolocation_sdk'

IpgeolocationSdk::GetBulkIpSecurityInfo200ResponseInner1.openapi_one_of
# =>
# [
#   :'ErrorXMLResponseArray',
#   :'SecurityAPIXMLResponseArray'
# ]
```

### build

Find the appropriate object from the `openapi_one_of` list and casts the data into it.

#### Example

```ruby
require 'ipgeolocation_sdk'

IpgeolocationSdk::GetBulkIpSecurityInfo200ResponseInner1.build(data)
# => #<ErrorXMLResponseArray:0x00007fdd4aab02a0>

IpgeolocationSdk::GetBulkIpSecurityInfo200ResponseInner1.build(data_that_doesnt_match)
# => nil
```

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| **data** | **Mixed** | data to be matched against the list of oneOf items |

#### Return type

- `ErrorXMLResponseArray`
- `SecurityAPIXMLResponseArray`
- `nil` (if no type matches)

