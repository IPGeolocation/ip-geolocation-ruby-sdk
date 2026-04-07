require "spec_helper"

RSpec.describe IpgeolocationSdk::LookupIpGeolocationRequest do
  it "normalizes tokens, headers, and output" do
    request = described_class.new(
      ip: " 8.8.8.8 ",
      lang: :EN,
      include: [" security ", "abuse"],
      fields: [" ip ", "location.country_name"],
      excludes: [" currency "],
      user_agent: " custom-agent ",
      headers: {
        "X-Test" => [" one ", "two "],
        "X-Trace" => " trace "
      },
      output: :json
    )

    expect(request.ip).to eq("8.8.8.8")
    expect(request.lang).to eq("en")
    expect(request.public_send(:include)).to eq(["security", "abuse"])
    expect(request.fields).to eq(["ip", "location.country_name"])
    expect(request.excludes).to eq(["currency"])
    expect(request.user_agent).to eq("custom-agent")
    expect(request.headers).to eq(
      {
        "X-Test" => ["one", "two"],
        "X-Trace" => ["trace"]
      }
    )
    expect(request.output).to eq("json")
  end

  it "rejects a string passed as include" do
    expect do
      described_class.new(include: "security")
    end.to raise_error(
      IpgeolocationSdk::ValidationError,
      "include must be an array of strings, not a single string"
    )
  end
end

RSpec.describe IpgeolocationSdk::BulkLookupIpGeolocationRequest do
  it "rejects empty ips" do
    expect do
      described_class.new(ips: [])
    end.to raise_error(IpgeolocationSdk::ValidationError, "ips must not be empty")
  end

  it "rejects header values with CR or LF" do
    expect do
      described_class.new(ips: ["8.8.8.8"], headers: { "X-Test" => "bad\nvalue" })
    end.to raise_error(IpgeolocationSdk::ValidationError, "header values must not contain CR or LF")
  end
end
