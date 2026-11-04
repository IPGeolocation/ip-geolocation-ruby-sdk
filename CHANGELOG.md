# Changelog

## 2.0.2

- Hide API keys in request errors and typed bulk error messages.
- Preserve HTTP error types and status codes when error responses are incomplete or invalid.
- Add Arabic (`ar`) for single and bulk lookups.

Existing public methods and Ruby 2.7+ support remain unchanged.

## 2.0.1

- Mask API keys in configuration serialization and client/config inspection.
- Enforce response-size limits while reading HTTP responses.
- Preserve UTF-8 across response chunks and replace malformed bytes without losing adjacent text.
- Correct Bundler test dependencies and add Ruby compatibility checks.

Existing public methods and Ruby 2.7+ support are unchanged.

## 2.0.0

- Replaced the old generated v1 gem with the new Ruby SDK for the IPGeolocation.io IP Location API.
- Added typed and raw single lookup methods for `/v3/ipgeo`.
- Added typed and raw bulk lookup methods for `/v3/ipgeo-bulk`.
- Added request validation, metadata parsing, JSON helpers, and explicit error mapping.
