# frozen_string_literal: true

require "net/http"
require "openssl"
require "uri"

module IpgeolocationSdk
  class HttpRequestData < ValueObject
    attributes :url, :method, :headers, :body, :connect_timeout, :read_timeout
  end

  class HttpResponseData < ValueObject
    attributes :status_code, :body, :headers
  end

  class NetHttpTransport
    DEFAULT_MAX_RESPONSE_BODY_CHARS = 128 * 1024 * 1024

    def initialize(max_response_body_chars: DEFAULT_MAX_RESPONSE_BODY_CHARS)
      raise ArgumentError, "max_response_body_chars must be a positive integer" unless max_response_body_chars.is_a?(Integer) && max_response_body_chars.positive?

      @max_response_body_chars = max_response_body_chars
    end

    def send_request(request)
      uri = URI.parse(request.url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == "https"
      http.open_timeout = request.connect_timeout
      http.read_timeout = request.read_timeout

      response = http.request(build_net_http_request(uri, request))
      body = response.body
      body = body.nil? ? read_response_body(response) : normalize_response_text(body.to_s)

      HttpResponseData.new(
        status_code: response.code.to_i,
        body: body,
        headers: normalize_headers(response.to_hash)
      )
    rescue Net::OpenTimeout => error
      raise RequestTimeoutError.new(
        "HTTP request timed out after #{timeout_ms(request.connect_timeout)}ms while opening the connection",
        cause: error
      )
    rescue Net::ReadTimeout => error
      raise RequestTimeoutError.new(
        "HTTP request timed out after #{timeout_ms(request.read_timeout)}ms while reading the response body",
        cause: error
      )
    rescue URI::InvalidURIError, SocketError, IOError, SystemCallError, OpenSSL::SSL::SSLError => error
      raise TransportError.new("HTTP transport error", cause: error)
    end

    def close
      nil
    end

    private

    def build_net_http_request(uri, request)
      klass =
        case request.method
        when "GET" then Net::HTTP::Get
        when "POST" then Net::HTTP::Post
        else
          raise ValidationError, "unsupported HTTP method: #{request.method}"
        end

      net_request = klass.new(uri.request_uri)
      request.headers.each do |name, values|
        next if values.nil? || values.empty?

        net_request[name] = values.length == 1 ? values.first : values.join(", ")
      end
      net_request.body = request.body unless request.body.nil?
      net_request
    end

    def read_response_body(response)
      body_parts = []

      response.read_body do |chunk|
        body_parts << normalize_response_text(chunk.to_s)
      end

      body_parts.join
    end

    def normalize_response_text(text)
      normalized = text.encode(Encoding::UTF_8, invalid: :replace, undef: :replace)
      if normalized.length > @max_response_body_chars
        raise TransportError, "Response body exceeded max size of #{@max_response_body_chars} characters"
      end

      normalized
    end

    def normalize_headers(headers)
      headers.each_with_object({}) do |(key, values), result|
        result[key] = Array(values).map(&:to_s).freeze
      end.freeze
    end

    def timeout_ms(seconds)
      (seconds * 1000).to_i
    end
  end
end
