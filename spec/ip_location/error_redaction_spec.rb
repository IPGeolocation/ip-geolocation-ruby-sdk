require "spec_helper"
require "cgi"
require "json"

RSpec.describe "Client error redaction" do
  let(:key) { "test-key+/with space&value" }
  let(:transport) { double("transport") }
  let(:client) { IpgeolocationSdk::IpGeolocationClient.new({ api_key: key }, transport) }

  def response(status, body)
    IpgeolocationSdk::HttpResponseData.new(status_code: status, body: body, headers: {})
  end

  {
    lookup_ip_geolocation: {},
    lookup_ip_geolocation_raw: {},
    bulk_lookup_ip_geolocation: { ips: ["8.8.8.8"] },
    bulk_lookup_ip_geolocation_raw: { ips: ["8.8.8.8"] }
  }.each do |method, request|
    it "masks API errors from #{method} without changing status or type" do
      {
        400 => IpgeolocationSdk::BadRequestError,
        401 => IpgeolocationSdk::UnauthorizedError,
        404 => IpgeolocationSdk::NotFoundError,
        405 => IpgeolocationSdk::MethodNotAllowedError,
        413 => IpgeolocationSdk::PayloadTooLargeError,
        415 => IpgeolocationSdk::UnsupportedMediaTypeError,
        423 => IpgeolocationSdk::LockedError,
        429 => IpgeolocationSdk::RateLimitError,
        499 => IpgeolocationSdk::ClientClosedRequestError,
        500 => IpgeolocationSdk::ServerError,
        503 => IpgeolocationSdk::ServerError,
        418 => IpgeolocationSdk::ApiError
      }.each do |status, error_class|
        [
          JSON.generate({ message: "Rejected #{key}" }),
          JSON.generate({ error: { message: "Rejected #{CGI.escape(key)}" } }),
          "<html>Rejected #{CGI.escapeHTML(key)}</html>"
        ].each do |body|
          allow(transport).to receive(:send_request).and_return(response(status, body))
          expect { client.public_send(method, request) }.to raise_error(error_class) do |error|
            expect(error.status_code).to eq(status)
            expect(error.message).to include("[REDACTED]")
            expect(error.api_message).to include("[REDACTED]")
            expect(error.full_message).not_to include(key, CGI.escape(key), CGI.escapeHTML(key))
          end
        end
      end
    end

    it "copies transport error details from #{method} without retaining the original" do
      original = IOError.new("Request #{key}")
      original.instance_variable_set(:@request_url, "https://example.test/?apiKey=#{key}")
      original.set_backtrace(["request #{key}:1"])
      failure = IpgeolocationSdk::RequestTimeoutError.new("Timeout #{key}", cause: original)
      allow(transport).to receive(:send_request).and_raise(failure)

      expect { client.public_send(method, request) }.to raise_error(IpgeolocationSdk::RequestTimeoutError) do |error|
        expect(error).not_to equal(failure)
        expect(error.message).to eq("Timeout [REDACTED]")
        expect(error.cause).not_to equal(original)
        expect(error.cause.message).to include("[REDACTED]")
        expect(error.cause.instance_variables).not_to include(:@request_url)
        expect(error.cause.backtrace.join).not_to include(key)
        expect(error.full_message).not_to include(key)
        expect(Exception.instance_method(:cause).bind(error).call).to be_nil
      end
      expect(original.message).to include(key)
    end
  end

  it "masks bulk error items while preserving successful data" do
    body = JSON.generate([{ ip: "8.8.8.8", hostname: key }, { success: false, message: "Rejected #{key}" }])
    allow(transport).to receive(:send_request).and_return(response(200, body))
    results = client.bulk_lookup_ip_geolocation(ips: ["8.8.8.8", "bad"]).data

    expect(results.first.data.hostname).to eq(key)
    expect(results.last.error.message).to eq("Rejected [REDACTED]")
    expect(results.last.success?).to eq(false)
  end

  it "preserves successful raw JSON and XML exactly" do
    ["{\"message\":\"#{key}\"}", "<response>#{key}</response>"].each do |body|
      allow(transport).to receive(:send_request).and_return(response(200, body))
      expect(client.lookup_ip_geolocation_raw.data).to eq(body)
      expect(client.bulk_lookup_ip_geolocation_raw(ips: ["8.8.8.8"]).data).to eq(body)
    end
  end

  it "redacts before shortening fallback error bodies" do
    ["x" * 500 + key, JSON.generate(["x" * 500 + key])].each do |body|
      allow(transport).to receive(:send_request).and_return(response(401, body))
      expect { client.lookup_ip_geolocation }.to raise_error(IpgeolocationSdk::UnauthorizedError) do |error|
        expect(error.api_message).not_to include(key[0, 10])
        expect(error.api_message.length).to be <= 512
      end
    end
  end

  it "preserves HTTP errors when the message is missing or not a string" do
    [nil, "", "null", "[]", "true", "not JSON", JSON.generate({ message: true }), JSON.generate({ error: { message: [] } })].each do |body|
      allow(transport).to receive(:send_request).and_return(response(401, body))
      expect { client.lookup_ip_geolocation }.to raise_error(IpgeolocationSdk::UnauthorizedError) do |error|
        expect(error.status_code).to eq(401)
      end
    end
  end

  it "handles repeated and escaped keys in errors" do
    special_key = "test-\"key\\value+/ space"
    special_client = IpgeolocationSdk::IpGeolocationClient.new({ api_key: special_key }, transport)
    escaped = CGI.escape(special_key).gsub(/%[0-9A-F]{2}/, &:downcase).gsub("+", "%20")
    body = JSON.generate({ message: "#{special_key} #{escaped} #{JSON.generate(special_key)[1...-1]}" })
    allow(transport).to receive(:send_request).and_return(response(401, body))
    expect { special_client.lookup_ip_geolocation }.to raise_error(IpgeolocationSdk::UnauthorizedError) do |error|
      expect(error.api_message).to eq("[REDACTED] [REDACTED] [REDACTED]")
    end
  end

  it "limits cyclic error causes without retaining the original chain" do
    failure = IpgeolocationSdk::TransportError.new("Request #{key}")
    failure.instance_variable_set(:@cause, failure)
    allow(transport).to receive(:send_request).and_raise(failure)
    expect { client.lookup_ip_geolocation }.to raise_error(IpgeolocationSdk::TransportError) do |error|
      seen = []
      while error
        expect(error).not_to equal(failure)
        expect(error.message).not_to include(key)
        seen << error
        expect(seen.length).to be <= 10
        error = error.cause
      end
    end
  end

  it "masks invalid JSON in parser error details" do
    allow(transport).to receive(:send_request).and_return(response(200, "{invalid: #{key}"))
    expect { client.lookup_ip_geolocation }.to raise_error(IpgeolocationSdk::SerializationError) do |error|
      expect(error.cause).not_to be_nil
      expect(error.cause.message).not_to include(key)
      expect(error.full_message).not_to include(key)
    end
  end

  it "keeps errors unchanged when no API key is configured" do
    failure = IpgeolocationSdk::TransportError.new("connection failed", cause: IOError.new("socket"))
    allow(transport).to receive(:send_request).and_raise(failure)
    origin_client = IpgeolocationSdk::IpGeolocationClient.new({ request_origin: "https://example.test" }, transport)
    expect { origin_client.lookup_ip_geolocation }.to raise_error { |error| expect(error).to equal(failure) }
  end

  it "uses the current API key when the configuration string changes" do
    client.config.api_key.replace("  rotated-test-key  ")
    allow(transport).to receive(:send_request) do |request|
      expect(request.url).to include("apiKey=rotated-test-key")
      response(401, JSON.generate({ message: "Rejected rotated-test-key" }))
    end
    expect { client.lookup_ip_geolocation }.to raise_error(IpgeolocationSdk::UnauthorizedError) do |error|
      expect(error.api_message).to eq("Rejected [REDACTED]")
    end
  end

  it "masks the request key even if the configuration changes during the request" do
    allow(transport).to receive(:send_request) do |request|
      expect(request.url).to include(CGI.escape(key))
      body = JSON.generate({ message: "Rejected #{key}" })
      client.config.api_key.replace("rotated-test-key")
      response(401, body)
    end
    expect { client.lookup_ip_geolocation }.to raise_error(IpgeolocationSdk::UnauthorizedError) do |error|
      expect(error.api_message).to eq("Rejected [REDACTED]")
    end
  end

  it "keeps a safe transport error when a custom constructor needs extra arguments" do
    custom_error = Class.new(IpgeolocationSdk::RequestTimeoutError) do
      def initialize(message, request:)
        super(message)
        @request = request
      end
    end
    failure = custom_error.new("Timeout #{key}", request: key)
    allow(transport).to receive(:send_request).and_raise(failure)
    expect { client.lookup_ip_geolocation }.to raise_error(IpgeolocationSdk::RequestTimeoutError) do |error|
      expect(error.message).to eq("Timeout [REDACTED]")
      expect(error.instance_variables).not_to include(:@request)
      expect(error.full_message).not_to include(key)
      expect(Exception.instance_method(:cause).bind(error).call).to be_nil
    end
  end

  it "retains validation error types and masks values echoed in validation messages" do
    expect { client.lookup_ip_geolocation(lang: key) }.to raise_error(IpgeolocationSdk::ValidationError) do |error|
      expect(error.message).to eq("Unsupported language code: [REDACTED]")
    end
    expect { client.lookup_ip_geolocation(ip: 42) }.to raise_error(TypeError, "ip must be a string")
  end
end
