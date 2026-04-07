# frozen_string_literal: true

require "time"

module IpgeolocationSdk
  class IpGeolocationClient
    def self.default_user_agent
      "ipgeolocation-ruby-sdk/#{VERSION}"
    end

    def initialize(config, transport = nil)
      raise TypeError, "config must not be nil" if config.nil?

      @config =
        case config
        when IpGeolocationClientConfig
          config
        when Hash
          IpGeolocationClientConfig.new(**config)
        else
          raise TypeError, "config must be an IpGeolocationClientConfig or hash"
        end

      @transport = transport || NetHttpTransport.new
      @owns_transport = transport.nil?
      @closed = false
    end

    attr_reader :config

    def lookup_ip_geolocation(request = nil)
      ensure_open
      typed_request = to_lookup_request(request)
      validate_lookup_request_base
      Serde.validate_json_output(typed_request.output)

      response, duration_ms = execute_with_metrics(build_lookup_http_request(typed_request))
      raise Serde.to_api_error(response.status_code, response.body) unless success_status?(response.status_code)

      ApiResponse.new(
        data: Serde.parse_single_lookup(response.body),
        metadata: Serde.to_metadata(response.status_code, duration_ms, response.headers)
      )
    end

    def lookup_ip_geolocation_raw(request = nil)
      ensure_open
      typed_request = to_lookup_request(request)
      validate_lookup_request_base

      response, duration_ms = execute_with_metrics(build_lookup_http_request(typed_request))
      raise Serde.to_api_error(response.status_code, response.body) unless success_status?(response.status_code)

      ApiResponse.new(
        data: response.body,
        metadata: Serde.to_metadata(response.status_code, duration_ms, response.headers)
      )
    end

    def bulk_lookup_ip_geolocation(request)
      ensure_open
      typed_request = to_bulk_request(request)
      validate_bulk_request_base
      Serde.validate_json_output(typed_request.output)

      response, duration_ms = execute_with_metrics(build_bulk_http_request(typed_request))
      raise Serde.to_api_error(response.status_code, response.body) unless success_status?(response.status_code)

      ApiResponse.new(
        data: Serde.parse_bulk_lookup(response.body),
        metadata: Serde.to_metadata(response.status_code, duration_ms, response.headers)
      )
    end

    def bulk_lookup_ip_geolocation_raw(request)
      ensure_open
      typed_request = to_bulk_request(request)
      validate_bulk_request_base

      response, duration_ms = execute_with_metrics(build_bulk_http_request(typed_request))
      raise Serde.to_api_error(response.status_code, response.body) unless success_status?(response.status_code)

      ApiResponse.new(
        data: response.body,
        metadata: Serde.to_metadata(response.status_code, duration_ms, response.headers)
      )
    end

    def close
      return if @closed

      @closed = true
      @transport.close if @owns_transport && @transport.respond_to?(:close)
      nil
    end

    private

    def ensure_open
      raise ValidationError, "client is closed" if @closed
    end

    def validate_lookup_request_base
      return unless @config.api_key.nil? && @config.request_origin.nil?

      raise ValidationError, "single lookup requires api_key or request_origin in client config"
    end

    def validate_bulk_request_base
      raise ValidationError, "bulk lookup requires api_key in client config" if @config.api_key.nil?
    end

    def to_lookup_request(request)
      case request
      when nil
        LookupIpGeolocationRequest.new
      when LookupIpGeolocationRequest
        request
      when Hash
        LookupIpGeolocationRequest.new(**request)
      else
        raise TypeError, "request must be a LookupIpGeolocationRequest, hash, or nil"
      end
    end

    def to_bulk_request(request)
      case request
      when BulkLookupIpGeolocationRequest
        request
      when Hash
        BulkLookupIpGeolocationRequest.new(**request)
      when nil
        raise ValidationError, "request must not be nil"
      else
        raise TypeError, "request must be a BulkLookupIpGeolocationRequest or hash"
      end
    end

    def build_lookup_http_request(request)
      output = request.output || ResponseFormat::JSON
      query = Serde.build_query(
        "apiKey" => @config.api_key,
        "ip" => request.ip,
        "lang" => request.lang,
        "include" => request.include.empty? ? nil : request.include.join(","),
        "fields" => request.fields.empty? ? nil : request.fields.join(","),
        "excludes" => request.excludes.empty? ? nil : request.excludes.join(","),
        "output" => output
      )

      headers = Serde.merge_headers(
        request.headers,
        @config.request_origin.nil? ? nil : { "Origin" => [@config.request_origin].freeze },
        {
          "User-Agent" => Serde.resolve_user_agent_header(
            request.user_agent,
            request.headers,
            self.class.default_user_agent
          ),
          "Accept" => [output == ResponseFormat::XML ? "application/xml" : "application/json"].freeze
        }.freeze
      )

      HttpRequestData.new(
        url: "#{@config.base_url}/v3/ipgeo#{query}",
        method: "GET",
        headers: headers,
        body: nil,
        connect_timeout: @config.connect_timeout,
        read_timeout: @config.read_timeout
      )
    end

    def build_bulk_http_request(request)
      output = request.output || ResponseFormat::JSON
      query = Serde.build_query(
        "apiKey" => @config.api_key,
        "lang" => request.lang,
        "include" => request.include.empty? ? nil : request.include.join(","),
        "fields" => request.fields.empty? ? nil : request.fields.join(","),
        "excludes" => request.excludes.empty? ? nil : request.excludes.join(","),
        "output" => output
      )

      payload = JSON.generate({ ips: request.ips })
      headers = Serde.merge_headers(
        request.headers,
        @config.request_origin.nil? ? nil : { "Origin" => [@config.request_origin].freeze },
        {
          "User-Agent" => Serde.resolve_user_agent_header(
            request.user_agent,
            request.headers,
            self.class.default_user_agent
          ),
          "Accept" => [output == ResponseFormat::XML ? "application/xml" : "application/json"].freeze,
          "Content-Type" => ["application/json"].freeze
        }.freeze
      )

      HttpRequestData.new(
        url: "#{@config.base_url}/v3/ipgeo-bulk#{query}",
        method: "POST",
        headers: headers,
        body: payload,
        connect_timeout: @config.connect_timeout,
        read_timeout: @config.read_timeout
      )
    rescue JSON::GeneratorError => error
      raise SerializationError.new("Failed to serialize bulk lookup request body", cause: error)
    end

    def execute_with_metrics(request)
      started_at = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      response = @transport.send_request(request)
      duration_ms = ((Process.clock_gettime(Process::CLOCK_MONOTONIC) - started_at) * 1000).floor
      [response, [duration_ms, 0].max]
    end

    def success_status?(status_code)
      status_code / 100 == 2
    end
  end
end
