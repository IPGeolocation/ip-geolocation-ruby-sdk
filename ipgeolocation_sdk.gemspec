require_relative "lib/ipgeolocation_sdk/version"

Gem::Specification.new do |s|
  s.name        = "ipgeolocation_sdk"
  s.version     = IpgeolocationSdk::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["IPGeolocation.io"]
  s.email       = ["support@ipgeolocation.io"]
  s.homepage    = "https://ipgeolocation.io"
  s.summary     = "Official Ruby SDK for the IPGeolocation.io IP Location API"
  s.description = "Ruby SDK for IPGeolocation.io single and bulk IP geolocation lookups with typed and raw responses."
  s.license     = "MIT"
  s.required_ruby_version = ">= 2.7"

  s.metadata = {
    "homepage_uri" => s.homepage,
    "source_code_uri" => "https://github.com/IPGeolocation/ip-geolocation-ruby-sdk",
    "bug_tracker_uri" => "https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/issues",
    "changelog_uri" => "https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/blob/main/CHANGELOG.md",
    "rubygems_mfa_required" => "true"
  }

  s.add_development_dependency "rake", "~> 13.0"
  s.add_development_dependency "rspec", "~> 3.13"

  s.files = [
    "CHANGELOG.md",
    "LICENSE",
    "README.md",
    "lib/ipgeolocation_sdk.rb",
    "lib/ipgeolocation_sdk/client.rb",
    "lib/ipgeolocation_sdk/client_config.rb",
    "lib/ipgeolocation_sdk/enums.rb",
    "lib/ipgeolocation_sdk/errors.rb",
    "lib/ipgeolocation_sdk/json_output.rb",
    "lib/ipgeolocation_sdk/models.rb",
    "lib/ipgeolocation_sdk/request_models.rb",
    "lib/ipgeolocation_sdk/serde.rb",
    "lib/ipgeolocation_sdk/transport.rb",
    "lib/ipgeolocation_sdk/value_object.rb",
    "lib/ipgeolocation_sdk/version.rb"
  ]
  s.executables   = []
  s.require_paths = ["lib"]
end
