require "spec_helper"

RSpec.describe IpgeolocationSdk::NetHttpTransport do
  it "sends a request and normalizes the response" do
    response = instance_double(
      "Net::HTTPResponse",
      code: "200",
      body: "{\"ip\":\"8.8.8.8\"}",
      to_hash: { "x-test" => ["ok"] }
    )

    http = instance_double("Net::HTTP")
    allow(Net::HTTP).to receive(:new).with("api.ipgeolocation.io", 443).and_return(http)
    allow(http).to receive(:use_ssl=).with(true)
    allow(http).to receive(:open_timeout=).with(5.0)
    allow(http).to receive(:read_timeout=).with(10.0)
    allow(http).to receive(:request).and_return(response)

    request = IpgeolocationSdk::HttpRequestData.new(
      url: "https://api.ipgeolocation.io/v3/ipgeo?ip=8.8.8.8",
      method: "GET",
      headers: {
        "User-Agent" => ["ipgeolocation-ruby-sdk/2.0.0"]
      },
      body: nil,
      connect_timeout: 5.0,
      read_timeout: 10.0
    )

    result = described_class.new.send_request(request)

    expect(result.status_code).to eq(200)
    expect(result.body).to eq("{\"ip\":\"8.8.8.8\"}")
    expect(result.headers).to eq({ "x-test" => ["ok"] })
  end

  it "maps read timeouts to RequestTimeoutError" do
    http = instance_double("Net::HTTP")
    allow(Net::HTTP).to receive(:new).with("api.ipgeolocation.io", 443).and_return(http)
    allow(http).to receive(:use_ssl=).with(true)
    allow(http).to receive(:open_timeout=).with(5.0)
    allow(http).to receive(:read_timeout=).with(10.0)
    allow(http).to receive(:request).and_raise(Net::ReadTimeout)

    request = IpgeolocationSdk::HttpRequestData.new(
      url: "https://api.ipgeolocation.io/v3/ipgeo?ip=8.8.8.8",
      method: "GET",
      headers: {},
      body: nil,
      connect_timeout: 5.0,
      read_timeout: 10.0
    )

    expect do
      described_class.new.send_request(request)
    end.to raise_error(
      IpgeolocationSdk::RequestTimeoutError,
      "HTTP request timed out after 10000ms while reading the response body"
    )
  end
end
