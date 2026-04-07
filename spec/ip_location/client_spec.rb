require "json"
require "spec_helper"

RSpec.describe IpgeolocationSdk::IpGeolocationClient do
  class RecordingTransport
    attr_reader :requests, :closed

    def initialize(*responses)
      @responses = responses
      @requests = []
      @closed = false
    end

    def send_request(request)
      @requests << request
      raise "no response queued" if @responses.empty?

      @responses.shift
    end

    def close
      @closed = true
    end
  end

  let(:config) do
    IpgeolocationSdk::IpGeolocationClientConfig.new(
      api_key: "paid-key",
      request_origin: "https://ipgeolocation.io"
    )
  end

  it "builds lookup requests and parses typed responses" do
    response = IpgeolocationSdk::HttpResponseData.new(
      status_code: 200,
      body: JSON.generate(
        {
          "ip" => "8.8.8.8",
          "hostname" => "dns.google",
          "location" => { "country_name" => "United States" }
        }
      ),
      headers: {
        "X-Credits-Charged" => ["1"],
        "X-Successful-Record" => ["1"]
      }
    )
    transport = RecordingTransport.new(response)
    client = described_class.new(config, transport)

    result = client.lookup_ip_geolocation(
      ip: "8.8.8.8",
      include: ["hostname"],
      headers: { "X-Test" => "trace" }
    )

    request = transport.requests.fetch(0)
    expect(request.url).to include("/v3/ipgeo?")
    expect(request.url).to include("apiKey=paid-key")
    expect(request.url).to include("ip=8.8.8.8")
    expect(request.url).to include("include=hostname")
    expect(request.url).to include("output=json")
    expect(request.method).to eq("GET")
    expect(request.headers["Origin"]).to eq(["https://ipgeolocation.io"])
    expect(request.headers["Accept"]).to eq(["application/json"])
    expect(request.headers["User-Agent"]).to eq(["ipgeolocation-ruby-sdk/#{IpgeolocationSdk::VERSION}"])
    expect(request.headers["X-Test"]).to eq(["trace"])

    expect(result.data.ip).to eq("8.8.8.8")
    expect(result.data.hostname).to eq("dns.google")
    expect(result.data.location.country_name).to eq("United States")
    expect(result.metadata.credits_charged).to eq(1)
    expect(result.metadata.successful_records).to eq(1)
  end

  it "rejects XML output on typed methods" do
    transport = RecordingTransport.new
    client = described_class.new(config, transport)

    expect do
      client.lookup_ip_geolocation(output: :xml)
    end.to raise_error(
      IpgeolocationSdk::ValidationError,
      "XML output is not supported by typed methods. Use ResponseFormat::JSON."
    )
  end

  it "requires api_key for bulk lookup" do
    client = described_class.new(api_key: nil, request_origin: "https://ipgeolocation.io", base_url: config.base_url)

    expect do
      client.bulk_lookup_ip_geolocation(ips: ["8.8.8.8"])
    end.to raise_error(IpgeolocationSdk::ValidationError, "bulk lookup requires api_key in client config")
  end

  it "rejects use after close" do
    transport = RecordingTransport.new
    client = described_class.new(config, transport)

    client.close

    expect do
      client.lookup_ip_geolocation
    end.to raise_error(IpgeolocationSdk::ValidationError, "client is closed")
  end
end
