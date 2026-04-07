# frozen_string_literal: true

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
end
