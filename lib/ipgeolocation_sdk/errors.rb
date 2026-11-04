# frozen_string_literal: true

require "cgi"
require "json"

module IpgeolocationSdk
  class IpGeolocationError < StandardError
    attr_reader :cause

    def initialize(message, cause: nil)
      super(message)
      @cause = cause
    end
  end

  class ValidationError < IpGeolocationError; end
  class SerializationError < IpGeolocationError; end
  class TransportError < IpGeolocationError; end
  class RequestTimeoutError < TransportError; end

  class ApiError < IpGeolocationError
    attr_reader :status_code, :api_message

    def initialize(message, status_code, api_message = nil)
      super(message)
      @status_code = status_code
      @api_message = api_message
    end
  end

  class BadRequestError < ApiError; end
  class UnauthorizedError < ApiError; end
  class NotFoundError < ApiError; end
  class MethodNotAllowedError < ApiError; end
  class PayloadTooLargeError < ApiError; end
  class UnsupportedMediaTypeError < ApiError; end
  class LockedError < ApiError; end
  class RateLimitError < ApiError; end
  class ClientClosedRequestError < ApiError; end
  class ServerError < ApiError; end

  class ErrorRedactor
    def initialize(api_key)
      return if api_key.nil? || api_key.empty?

      key = api_key.encode(Encoding::UTF_8, invalid: :replace, undef: :replace)
      escaped = CGI.escape(key)
      forms = [key, escaped, escaped.gsub("+", "%20"), CGI.escapeHTML(key),
               JSON.generate(key)[1...-1], JSON.generate(key, ascii_only: true)[1...-1]]
      patterns = forms.uniq.sort_by { |form| -form.length }.map do |form|
        Regexp.escape(form).gsub(/%[0-9A-F]{2}/) { |escape| "(?i:#{escape})" }
      end
      @pattern = Regexp.new(patterns.join("|"))
    end

    def text(value)
      return value if value.nil? || @pattern.nil?

      value.encode(Encoding::UTF_8, invalid: :replace, undef: :replace).gsub(@pattern, "[REDACTED]")
    end

    def copy(error, depth = 0)
      return nil if error.nil? || depth >= 8

      message = error.is_a?(JSON::ParserError) ? "Invalid JSON response" : text(error.message)
      cause = copy(error.cause, depth + 1)
      sanitized =
        begin
          if error.is_a?(ApiError)
            error.class.new(message, error.status_code, text(error.api_message))
          elsif error.is_a?(IpGeolocationError)
            error.class.new(message, cause: cause)
          else
            error.class.new(message)
          end
        rescue StandardError
          if error.is_a?(ApiError)
            ApiError.new(message, error.status_code, text(error.api_message))
          elsif error.is_a?(IpGeolocationError)
            klass = [RequestTimeoutError, TransportError, ValidationError, SerializationError, IpGeolocationError].find do |type|
              error.is_a?(type)
            end
            klass.new(message, cause: cause)
          else
            StandardError.new(message)
          end
        end
      sanitized.set_backtrace(error.backtrace&.map { |line| text(line) })
      sanitized
    end
  end
  private_constant :ErrorRedactor
end
