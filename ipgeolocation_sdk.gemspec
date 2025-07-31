# ipgeolocation.gemspec
require_relative "lib/ipgeolocation_sdk/version"

Gem::Specification.new do |s|
  s.name        = "ipgeolocation_sdk"
  s.version     = IpgeolocationSdk::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["IPGeolocation.io"]
  s.email       = ["support@ipgeolocation.io"]
  s.homepage    = "https://ipgeolocation.io"
  s.summary     = "Official Ruby SDK for IPGeolocation.io APIs"
  s.description = "A Ruby wrapper for the IPGeolocation.io API suite, providing geolocation, ip security, timezone, currency, user-agent, and other IP intelligence features. Easily integrate IP data into your Ruby applications."  
  s.license     = "MIT"
  s.required_ruby_version = ">= 2.7"

  s.metadata = {
    "homepage_uri" => s.homepage,
    "source_code_uri" => "https://github.com/IPGeolocation/ip-geolocation-ruby-sdk", 
    "bug_tracker_uri" => "https://github.com/IPGeolocation/ip-geolocation-ruby-sdk/issues" 
  }

  s.add_runtime_dependency 'typhoeus', '~> 1.0', '>= 1.0.1'
  s.add_development_dependency 'rspec', '~> 3.6', '>= 3.6.0'

  s.files         = `find *`.split("\n").uniq.sort.select { |f| !f.empty? }
  s.test_files    = `find spec/*`.split("\n")
  s.executables   = []
  s.require_paths = ["lib"]
end
