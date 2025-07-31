# IpgeolocationSdk::UserAgentXMLDataArray

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **user_agent_string** | **String** |  | [optional] |
| **name** | **String** |  | [optional] |
| **type** | **String** |  | [optional] |
| **version** | **String** |  | [optional] |
| **version_major** | **String** |  | [optional] |
| **device** | [**UserAgentDataDevice**](UserAgentDataDevice.md) |  | [optional] |
| **engine** | [**UserAgentDataEngine**](UserAgentDataEngine.md) |  | [optional] |
| **operating_system** | [**UserAgentDataOperatingSystem**](UserAgentDataOperatingSystem.md) |  | [optional] |

## Example

```ruby
require 'ipgeolocation_sdk'

instance = IpgeolocationSdk::UserAgentXMLDataArray.new(
  user_agent_string: null,
  name: null,
  type: null,
  version: null,
  version_major: null,
  device: null,
  engine: null,
  operating_system: null
)
```

