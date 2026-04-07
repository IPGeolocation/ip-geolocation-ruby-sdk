# frozen_string_literal: true

require "cgi"
require "json"

module IpgeolocationSdk
  module Serde
    module_function

    def parse_single_lookup(body)
      payload = parse_json(body, "Failed to deserialize API response")
      raise SerializationError, "Failed to deserialize API response" unless payload.is_a?(Hash)

      parse_ip_geolocation_response(payload)
    end

    def parse_bulk_lookup(body)
      payload = parse_json(body, "Failed to deserialize bulk lookup response")
      unless payload.is_a?(Array)
        raise SerializationError, "Failed to deserialize bulk response: expected an array payload"
      end

      payload.map do |item|
        if bulk_error_item?(item)
          BulkLookupError.new(
            error: BulkLookupErrorDetails.new(message: string_or_nil(item["message"]))
          )
        else
          raise SerializationError, "Failed to deserialize API response" unless item.is_a?(Hash)

          BulkLookupSuccess.new(data: parse_ip_geolocation_response(item))
        end
      end.freeze
    end

    def build_query(params)
      items = params.each_with_object([]) do |(key, value), result|
        next if key.nil? || value.nil?

        key_text = key.to_s.strip
        value_text = value.to_s.strip
        next if key_text.empty? || value_text.empty?

        result << "#{CGI.escape(key_text)}=#{CGI.escape(value_text)}"
      end

      items.empty? ? "" : "?#{items.join('&')}"
    end

    def merge_headers(*header_maps)
      merged = {}
      names_by_lower = {}

      header_maps.compact.each do |header_map|
        header_map.each do |raw_name, raw_values|
          next if raw_name.nil?

          name = raw_name.to_s.strip
          next if name.empty?

          existing_name = names_by_lower[name.downcase]
          merged.delete(existing_name) if existing_name && existing_name != name
          names_by_lower[name.downcase] = name
          merged[name] = Array(raw_values).map(&:to_s).freeze
        end
      end

      merged.freeze
    end

    def resolve_user_agent_header(request_user_agent, request_headers, default_user_agent)
      return [request_user_agent].freeze unless request_user_agent.nil?

      custom = first_header_ignore_case(request_headers, "User-Agent")
      return [custom].freeze unless custom.nil?

      [default_user_agent].freeze
    end

    def validate_json_output(output)
      return unless ResponseFormat.normalize(output) == ResponseFormat::XML

      raise ValidationError, "XML output is not supported by typed methods. Use ResponseFormat::JSON."
    end

    def to_api_error(status_code, body)
      api_message = extract_api_message(body)
      message =
        if api_message.nil?
          "API request failed with HTTP status #{status_code}"
        else
          "API request failed with HTTP status #{status_code}: #{api_message}"
        end

      klass =
        case status_code
        when 400 then BadRequestError
        when 401 then UnauthorizedError
        when 404 then NotFoundError
        when 405 then MethodNotAllowedError
        when 413 then PayloadTooLargeError
        when 415 then UnsupportedMediaTypeError
        when 423 then LockedError
        when 429 then RateLimitError
        when 499 then ClientClosedRequestError
        else
          status_code.between?(500, 599) ? ServerError : ApiError
        end

      klass.new(message, status_code, api_message)
    end

    def extract_api_message(body)
      return nil if body.nil?

      normalized = body.to_s.strip
      return nil if normalized.empty?

      payload = JSON.parse(normalized)
      return normalized[0, 512] unless payload.is_a?(Hash)

      message = payload["message"]
      if message.nil? && payload["error"].is_a?(Hash)
        message = payload["error"]["message"]
      end
      string_or_nil(message) || normalized[0, 512]
    rescue JSON::ParserError
      normalized[0, 512]
    end

    def parse_int_header(value)
      return nil if value.nil?

      normalized = value.to_s.strip
      return nil unless normalized.match?(/\A\d+\z/)

      Integer(normalized, 10)
    end

    def first_header_ignore_case(headers, name)
      headers.each do |key, values|
        return values.first if key.casecmp?(name)
      end
      nil
    end

    def to_metadata(status_code, duration_ms, raw_headers)
      headers = raw_headers || {}.freeze
      ApiResponseMetadata.new(
        credits_charged: parse_int_header(first_header_ignore_case(headers, "X-Credits-Charged")),
        successful_records: parse_int_header(first_header_ignore_case(headers, "X-Successful-Record")),
        status_code: status_code,
        duration_ms: duration_ms,
        raw_headers: headers
      )
    end

    def to_plain_data(value, mode = JsonOutputMode::COMPACT)
      normalized_mode = JsonOutputMode.normalize(mode)

      case value
      when ValueObject
        value.class.attribute_names.each_with_object({}) do |name, result|
          item = value.public_send(name)
          next if normalized_mode == JsonOutputMode::COMPACT && item.nil?

          result[name.to_s] = to_plain_data(item, normalized_mode)
        end
      when Array
        value.map { |item| to_plain_data(item, normalized_mode) }
      when Hash
        value.each_with_object({}) do |(key, item), result|
          next if normalized_mode == JsonOutputMode::COMPACT && item.nil?

          result[key] = to_plain_data(item, normalized_mode)
        end
      else
        value
      end
    end

    def parse_ip_geolocation_response(node)
      IpGeolocationResponse.new(
        ip: string_or_nil(node["ip"]),
        domain: string_or_nil(node["domain"]),
        hostname: string_or_nil(node["hostname"]),
        location: parse_optional_object(node["location"]) { |item| parse_location(item) },
        country_metadata: parse_optional_object(node["country_metadata"]) { |item| parse_country_metadata(item) },
        network: parse_optional_object(node["network"]) { |item| parse_network(item) },
        currency: parse_optional_object(node["currency"]) { |item| parse_currency(item) },
        asn: parse_optional_object(node["asn"]) { |item| parse_asn(item) },
        company: parse_optional_object(node["company"]) { |item| parse_company(item) },
        security: parse_optional_object(node["security"]) { |item| parse_security(item) },
        abuse: parse_optional_object(node["abuse"]) { |item| parse_abuse(item) },
        time_zone: parse_optional_object(node["time_zone"]) { |item| parse_time_zone_info(item) },
        user_agent: parse_optional_object(node["user_agent"]) { |item| parse_user_agent(item) }
      )
    end

    def parse_abuse(node)
      Abuse.new(
        route: string_or_nil(node["route"]),
        country: string_or_nil(node["country"]),
        name: string_or_nil(node["name"]),
        organization: string_or_nil(node["organization"]),
        kind: string_or_nil(node["kind"]),
        address: string_or_nil(node["address"]),
        emails: string_array_or_nil(node["emails"]),
        phone_numbers: string_array_or_nil(node["phone_numbers"])
      )
    end

    def parse_asn(node)
      Asn.new(
        as_number: string_or_nil(node["as_number"]),
        organization: string_or_nil(node["organization"]),
        country: string_or_nil(node["country"]),
        type: string_or_nil(node["type"]),
        domain: string_or_nil(node["domain"]),
        date_allocated: string_or_nil(node["date_allocated"]),
        rir: string_or_nil(node["rir"])
      )
    end

    def parse_company(node)
      Company.new(
        name: string_or_nil(node["name"]),
        type: string_or_nil(node["type"]),
        domain: string_or_nil(node["domain"])
      )
    end

    def parse_country_metadata(node)
      CountryMetadata.new(
        calling_code: string_or_nil(node["calling_code"]),
        tld: string_or_nil(node["tld"]),
        languages: string_array_or_nil(node["languages"])
      )
    end

    def parse_currency(node)
      Currency.new(
        code: string_or_nil(node["code"]),
        name: string_or_nil(node["name"]),
        symbol: string_or_nil(node["symbol"])
      )
    end

    def parse_dst_transition(node)
      DstTransition.new(
        utc_time: string_or_nil(node["utc_time"]),
        duration: string_or_nil(node["duration"]),
        gap: boolean_or_nil(node["gap"]),
        date_time_after: string_or_nil(node["date_time_after"]),
        date_time_before: string_or_nil(node["date_time_before"]),
        overlap: boolean_or_nil(node["overlap"])
      )
    end

    def parse_location(node)
      Location.new(
        continent_code: string_or_nil(node["continent_code"]),
        continent_name: string_or_nil(node["continent_name"]),
        country_code2: string_or_nil(node["country_code2"]),
        country_code3: string_or_nil(node["country_code3"]),
        country_name: string_or_nil(node["country_name"]),
        country_name_official: string_or_nil(node["country_name_official"]),
        country_capital: string_or_nil(node["country_capital"]),
        state_prov: string_or_nil(node["state_prov"]),
        state_code: string_or_nil(node["state_code"]),
        district: string_or_nil(node["district"]),
        city: string_or_nil(node["city"]),
        locality: string_or_nil(node["locality"]),
        accuracy_radius: string_or_nil(node["accuracy_radius"]),
        confidence: LocationConfidence.normalize(node["confidence"]),
        dma_code: string_or_nil(node["dma_code"]),
        zipcode: string_or_nil(node["zipcode"]),
        latitude: string_or_nil(node["latitude"]),
        longitude: string_or_nil(node["longitude"]),
        is_eu: boolean_or_nil(node["is_eu"]),
        country_flag: string_or_nil(node["country_flag"]),
        geoname_id: string_or_nil(node["geoname_id"]),
        country_emoji: string_or_nil(node["country_emoji"])
      )
    end

    def parse_network(node)
      Network.new(
        connection_type: string_or_nil(node["connection_type"]),
        route: string_or_nil(node["route"]),
        is_anycast: boolean_or_nil(node["is_anycast"])
      )
    end

    def parse_security(node)
      Security.new(
        threat_score: numeric_or_nil(node["threat_score"]),
        is_tor: boolean_or_nil(node["is_tor"]),
        is_proxy: boolean_or_nil(node["is_proxy"]),
        proxy_provider_names: string_array_or_nil(node["proxy_provider_names"]),
        proxy_confidence_score: numeric_or_nil(node["proxy_confidence_score"]),
        proxy_last_seen: string_or_nil(node["proxy_last_seen"]),
        is_residential_proxy: boolean_or_nil(node["is_residential_proxy"]),
        is_vpn: boolean_or_nil(node["is_vpn"]),
        vpn_provider_names: string_array_or_nil(node["vpn_provider_names"]),
        vpn_confidence_score: numeric_or_nil(node["vpn_confidence_score"]),
        vpn_last_seen: string_or_nil(node["vpn_last_seen"]),
        is_relay: boolean_or_nil(node["is_relay"]),
        relay_provider_name: string_or_nil(node["relay_provider_name"]),
        is_anonymous: boolean_or_nil(node["is_anonymous"]),
        is_known_attacker: boolean_or_nil(node["is_known_attacker"]),
        is_bot: boolean_or_nil(node["is_bot"]),
        is_spam: boolean_or_nil(node["is_spam"]),
        is_cloud_provider: boolean_or_nil(node["is_cloud_provider"]),
        cloud_provider_name: string_or_nil(node["cloud_provider_name"])
      )
    end

    def parse_time_zone_info(node)
      TimeZoneInfo.new(
        name: string_or_nil(node["name"]),
        offset: numeric_or_nil(node["offset"]),
        offset_with_dst: numeric_or_nil(node["offset_with_dst"]),
        current_time: string_or_nil(node["current_time"]),
        current_time_unix: numeric_or_nil(node["current_time_unix"]),
        current_tz_abbreviation: string_or_nil(node["current_tz_abbreviation"]),
        current_tz_full_name: string_or_nil(node["current_tz_full_name"]),
        standard_tz_abbreviation: string_or_nil(node["standard_tz_abbreviation"]),
        standard_tz_full_name: string_or_nil(node["standard_tz_full_name"]),
        is_dst: boolean_or_nil(node["is_dst"]),
        dst_savings: numeric_or_nil(node["dst_savings"]),
        dst_exists: boolean_or_nil(node["dst_exists"]),
        dst_tz_abbreviation: string_or_nil(node["dst_tz_abbreviation"]),
        dst_tz_full_name: string_or_nil(node["dst_tz_full_name"]),
        dst_start: parse_optional_object(node["dst_start"]) { |item| parse_dst_transition(item) },
        dst_end: parse_optional_object(node["dst_end"]) { |item| parse_dst_transition(item) }
      )
    end

    def parse_user_agent(node)
      UserAgent.new(
        user_agent_string: string_or_nil(node["user_agent_string"]),
        name: string_or_nil(node["name"]),
        type: string_or_nil(node["type"]),
        version: string_or_nil(node["version"]),
        version_major: string_or_nil(node["version_major"]),
        device: parse_optional_object(node["device"]) { |item| parse_user_agent_device(item) },
        engine: parse_optional_object(node["engine"]) { |item| parse_user_agent_engine(item) },
        operating_system: parse_optional_object(node["operating_system"]) { |item| parse_user_agent_operating_system(item) }
      )
    end

    def parse_user_agent_device(node)
      UserAgentDevice.new(
        name: string_or_nil(node["name"]),
        type: string_or_nil(node["type"]),
        brand: string_or_nil(node["brand"]),
        cpu: string_or_nil(node["cpu"])
      )
    end

    def parse_user_agent_engine(node)
      UserAgentEngine.new(
        name: string_or_nil(node["name"]),
        type: string_or_nil(node["type"]),
        version: string_or_nil(node["version"]),
        version_major: string_or_nil(node["version_major"])
      )
    end

    def parse_user_agent_operating_system(node)
      UserAgentOperatingSystem.new(
        name: string_or_nil(node["name"]),
        type: string_or_nil(node["type"]),
        version: string_or_nil(node["version"]),
        version_major: string_or_nil(node["version_major"]),
        build: string_or_nil(node["build"])
      )
    end

    def parse_optional_object(value)
      return nil if value.nil?
      raise SerializationError, "Failed to deserialize API response" unless value.is_a?(Hash)

      yield(value)
    end

    def string_or_nil(value)
      return nil if value.nil?
      raise SerializationError, "Failed to deserialize API response" unless value.is_a?(String)

      value
    end

    def numeric_or_nil(value)
      return nil if value.nil?
      raise SerializationError, "Failed to deserialize API response" unless value.is_a?(Numeric)

      value
    end

    def boolean_or_nil(value)
      return nil if value.nil?
      raise SerializationError, "Failed to deserialize API response" unless value == true || value == false

      value
    end

    def string_array_or_nil(value)
      return nil if value.nil?
      raise SerializationError, "Failed to deserialize API response" unless value.is_a?(Array)

      value.map do |item|
        raise SerializationError, "Failed to deserialize API response" unless item.is_a?(String)

        item
      end.freeze
    end

    def parse_json(body, message)
      JSON.parse(body)
    rescue JSON::ParserError, TypeError => error
      raise SerializationError.new(message, cause: error)
    end

    def bulk_error_item?(item)
      return false unless item.is_a?(Hash)
      return false if item["success"] == true

      item["success"] == false || item.key?("message")
    end
  end
end
