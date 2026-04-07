# frozen_string_literal: true

require "ipgeolocation_sdk/version"
require "ipgeolocation_sdk/errors"
require "ipgeolocation_sdk/enums"
require "ipgeolocation_sdk/value_object"
require "ipgeolocation_sdk/models"
require "ipgeolocation_sdk/request_models"
require "ipgeolocation_sdk/client_config"
require "ipgeolocation_sdk/transport"
require "ipgeolocation_sdk/serde"
require "ipgeolocation_sdk/json_output"
require "ipgeolocation_sdk/client"

module IpgeolocationSdk
  class << self
    def to_json(value, mode = JsonOutputMode::COMPACT)
      JsonOutput.to_json(value, mode)
    end

    def to_pretty_json(value, mode = JsonOutputMode::COMPACT)
      JsonOutput.to_pretty_json(value, mode)
    end
  end
end
