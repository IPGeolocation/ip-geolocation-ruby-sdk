# IpgeolocationSdk::CountryMetadata

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **calling_code** | **String** |  | [optional] |
| **tld** | **String** |  | [optional] |
| **languages** | **Array&lt;String&gt;** |  | [optional] |

## Example

```ruby
require 'ipgeolocation_sdk'

instance = IpgeolocationSdk::CountryMetadata.new(
  calling_code: +1,
  tld: .us,
  languages: [&quot;en-US&quot;,&quot;es-US&quot;,&quot;haw&quot;,&quot;fr&quot;]
)
```

