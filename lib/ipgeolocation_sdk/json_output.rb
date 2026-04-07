# frozen_string_literal: true

require "json"

module IpgeolocationSdk
  module JsonOutput
    module_function

    def to_json(value, mode = JsonOutputMode::COMPACT)
      write(value, mode, pretty: false)
    end

    def to_pretty_json(value, mode = JsonOutputMode::COMPACT)
      write(value, mode, pretty: true)
    end

    def write(value, mode, pretty:)
      normalized_mode = JsonOutputMode.normalize(mode)
      payload = Serde.to_plain_data(value, normalized_mode)
      if pretty
        JSON.pretty_generate(payload)
      else
        JSON.generate(payload)
      end
    rescue StandardError => error
      raise SerializationError.new("Failed to serialize output as JSON", cause: error)
    end
    private_class_method :write
  end
end
