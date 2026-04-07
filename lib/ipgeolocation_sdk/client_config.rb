# frozen_string_literal: true

require "uri"

module IpgeolocationSdk
  class IpGeolocationClientConfig < ValueObject
    DEFAULT_BASE_URL = "https://api.ipgeolocation.io"
    DEFAULT_CONNECT_TIMEOUT = 10.0
    DEFAULT_READ_TIMEOUT = 30.0

    attributes :api_key, :request_origin, :base_url, :connect_timeout, :read_timeout

    def initialize(
      api_key: nil,
      request_origin: nil,
      base_url: DEFAULT_BASE_URL,
      connect_timeout: DEFAULT_CONNECT_TIMEOUT,
      read_timeout: DEFAULT_READ_TIMEOUT
    )
      super(
        api_key: normalize_api_key(api_key),
        request_origin: normalize_request_origin(request_origin),
        base_url: normalize_base_url(base_url),
        connect_timeout: normalize_timeout(connect_timeout, "connect_timeout"),
        read_timeout: normalize_timeout(read_timeout, "read_timeout")
      )
    end

    private

    def normalize_api_key(value)
      return nil if value.nil?
      raise TypeError, "api_key must be a string" unless value.is_a?(String)

      normalized = value.strip
      raise ValidationError, "api_key must not be blank" if normalized.empty?

      normalized
    end

    def normalize_request_origin(value)
      return nil if value.nil?
      raise TypeError, "request_origin must be a string" unless value.is_a?(String)

      normalized = value.strip
      raise ValidationError, "request_origin must not be blank" if normalized.empty?
      raise ValidationError, "request_origin must not contain CR or LF" if normalized.include?("\r") || normalized.include?("\n")

      uri = parse_uri(normalized, "request_origin must be an absolute http or https origin")

      unless %w[http https].include?(uri.scheme) && uri.host
        raise ValidationError, "request_origin must be an absolute http or https origin"
      end
      raise ValidationError, "request_origin must not include a path" unless ["", "/"].include?(uri.path.to_s)
      raise ValidationError, "request_origin must not include params, query, or fragment" unless [nil, ""].include?(uri.query) && [nil, ""].include?(uri.fragment)
      raise ValidationError, "request_origin must not include userinfo" unless uri.userinfo.nil?

      "#{uri.scheme}://#{uri.host}#{port_suffix(uri)}"
    end

    def normalize_base_url(value)
      raise TypeError, "base_url must be a string" unless value.is_a?(String)

      normalized = value.strip.sub(%r{/+\z}, "")
      raise ValidationError, "base_url must not be blank" if normalized.empty?

      uri = parse_uri(normalized, "base_url must be an absolute http or https URL")

      unless %w[http https].include?(uri.scheme) && uri.host
        raise ValidationError, "base_url must be an absolute http or https URL"
      end
      raise ValidationError, "base_url must not include params, query, or fragment" unless [nil, ""].include?(uri.query) && [nil, ""].include?(uri.fragment)
      raise ValidationError, "base_url must not include userinfo" unless uri.userinfo.nil?

      normalized
    end

    def normalize_timeout(value, field)
      raise TypeError, "#{field} must be a number" unless value.is_a?(Numeric) && !value.is_a?(TrueClass) && !value.is_a?(FalseClass)

      normalized = value.to_f
      raise ValidationError, "#{field} must be finite" unless normalized.finite?
      raise ValidationError, "#{field} must be greater than zero" unless normalized.positive?

      normalized
    end

    def parse_uri(value, message)
      URI.parse(value)
    rescue URI::InvalidURIError
      raise ValidationError, message
    end

    def port_suffix(uri)
      return "" if uri.port.nil?
      return "" if uri.scheme == "http" && uri.port == 80
      return "" if uri.scheme == "https" && uri.port == 443

      ":#{uri.port}"
    end
  end
end
