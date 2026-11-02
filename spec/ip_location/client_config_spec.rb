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

  it "redacts the API key in config and client inspection without changing authentication" do
    config = described_class.new(api_key: "private-test-key")
    client = IpgeolocationSdk::IpGeolocationClient.new(config)

    expect(config.inspect).to include("[REDACTED]")
    expect(config.inspect).not_to include("private-test-key")
    expect(client.inspect).not_to include("private-test-key")
    expect(config.api_key).to eq("private-test-key")
  end

  it "redacts configuration keys in hashes and nested JSON in both output modes" do
    config = described_class.new(api_key: "private-test-key", read_timeout: 15)

    [:compact, :full].each do |mode|
      expect(config.to_h(mode: mode)).to include("api_key" => "[REDACTED]", "read_timeout" => 15.0)
      [IpgeolocationSdk.to_json({ config: [config] }, mode),
       IpgeolocationSdk.to_pretty_json(config, mode)].each do |json|
        expect(json).to include("[REDACTED]")
        expect(json).not_to include("private-test-key")
      end
    end
  end

  it "keeps absent API keys absent in compact output and nil in full output" do
    config = described_class.new(request_origin: "https://ipgeolocation.io")

    expect(config.to_h).not_to have_key("api_key")
    expect(config.to_h(mode: :full)).to include("api_key" => nil)
  end
end
