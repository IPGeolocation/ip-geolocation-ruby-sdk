# IpgeolocationSdk::ASNResponseXMLAsn

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **as_number** | **String** |  | [optional] |
| **organization** | **String** |  | [optional] |
| **country** | **String** |  | [optional] |
| **asn_name** | **String** |  | [optional] |
| **type** | **String** |  | [optional] |
| **domain** | **String** |  | [optional] |
| **date_allocated** | **Date** |  | [optional] |
| **allocation_status** | **String** |  | [optional] |
| **num_of_ipv4_routes** | **Integer** |  | [optional] |
| **num_of_ipv6_routes** | **Integer** |  | [optional] |
| **rir** | **String** |  | [optional] |
| **routes** | **Array&lt;String&gt;** | It will only be included in the response, if you set include&#x3D;routes in the request | [optional] |
| **upstreams** | [**Array&lt;ASNConnection&gt;**](ASNConnection.md) |  | [optional] |
| **downstreams** | [**Array&lt;ASNConnection&gt;**](ASNConnection.md) |  | [optional] |
| **peers** | [**Array&lt;ASNConnection&gt;**](ASNConnection.md) |  | [optional] |
| **whois_response** | **String** |  | [optional] |

## Example

```ruby
require 'ipgeolocation_sdk'

instance = IpgeolocationSdk::ASNResponseXMLAsn.new(
  as_number: AS3269,
  organization: Telecom Italia S.p.A.,
  country: IT,
  asn_name: ASN-IBSNAZ,
  type: ISP,
  domain: business.telecomitalia.it,
  date_allocated: Mon Nov 14 05:00:00 PKT 1994,
  allocation_status: allocated,
  num_of_ipv4_routes: 490,
  num_of_ipv6_routes: 4,
  rir: RIPE,
  routes: [&quot;192.76.177.0/24&quot;,&quot;216.165.96.0/20&quot;,&quot;216.165.89.0/24&quot;],
  upstreams: null,
  downstreams: null,
  peers: null,
  whois_response: whois output as a single string...
)
```

