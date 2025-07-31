# IpgeolocationSdk::Security

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **threat_score** | **Integer** |  | [optional] |
| **is_tor** | **Boolean** |  | [optional] |
| **is_proxy** | **Boolean** |  | [optional] |
| **proxy_type** | **String** |  | [optional] |
| **proxy_provider** | **String** |  | [optional] |
| **is_anonymous** | **Boolean** |  | [optional] |
| **is_known_attacker** | **Boolean** |  | [optional] |
| **is_spam** | **Boolean** |  | [optional] |
| **is_bot** | **Boolean** |  | [optional] |
| **is_cloud_provider** | **Boolean** |  | [optional] |
| **cloud_provider** | **String** |  | [optional] |

## Example

```ruby
require 'ipgeolocation_sdk'

instance = IpgeolocationSdk::Security.new(
  threat_score: 80,
  is_tor: false,
  is_proxy: true,
  proxy_type: VPN,
  proxy_provider: ,
  is_anonymous: true,
  is_known_attacker: true,
  is_spam: false,
  is_bot: false,
  is_cloud_provider: false,
  cloud_provider: 
)
```

