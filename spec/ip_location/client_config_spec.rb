require "spec_helper"

RSpec.describe IpgeolocationSdk::IpGeolocationClientConfig do
  it "normalizes API key, request origin, and base URL" do
    config = described_class.new(
      api_key: "  test-key  ",
      request_origin: "https://ipgeolocation.io:443",
      base_url: "https://api.ipgeolocation.io/",
      connect_timeout: 5,
      read_timeout: 12.5
    )

    expect(config.api_key).to eq("test-key")
    expect(config.request_origin).to eq("https://ipgeolocation.io")
    expect(config.base_url).to eq("https://api.ipgeolocation.io")
    expect(config.connect_timeout).to eq(5.0)
    expect(config.read_timeout).to eq(12.5)
  end

  it "rejects request_origin values with a path" do
    expect do
      described_class.new(request_origin: "https://ipgeolocation.io/path")
    end.to raise_error(IpgeolocationSdk::ValidationError, "request_origin must not include a path")
  end

  it "rejects non-positive timeout values" do
    expect do
      described_class.new(connect_timeout: 0)
    end.to raise_error(IpgeolocationSdk::ValidationError, "connect_timeout must be greater than zero")
  end
end
