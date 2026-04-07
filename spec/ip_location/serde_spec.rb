require "json"
require "spec_helper"

RSpec.describe IpgeolocationSdk::Serde do
  it "parses bulk lookup success and error items with the current public shape" do
    payload = JSON.generate(
      [
        {
          "ip" => "8.8.8.8",
          "location" => { "country_name" => "United States" }
        },
        {
          "ip" => "1.1.1.1",
          "message" => "Invalid IP address"
        }
      ]
    )

    results = described_class.parse_bulk_lookup(payload)

    expect(results.length).to eq(2)
    expect(results[0]).to be_a(IpgeolocationSdk::BulkLookupSuccess)
    expect(results[0].success?).to eq(true)
    expect(results[0].data.ip).to eq("8.8.8.8")
    expect(results[0].data.location.country_name).to eq("United States")

    expect(results[1]).to be_a(IpgeolocationSdk::BulkLookupError)
    expect(results[1].success?).to eq(false)
    expect(results[1].error.message).to eq("Invalid IP address")
  end

  it "extracts nested API error messages" do
    error = described_class.to_api_error(401, JSON.generate({ "error" => { "message" => "bad key" } }))

    expect(error).to be_a(IpgeolocationSdk::UnauthorizedError)
    expect(error.status_code).to eq(401)
    expect(error.api_message).to eq("bad key")
    expect(error.message).to include("bad key")
  end

  it "parses integer metadata headers strictly" do
    metadata = described_class.to_metadata(
      200,
      14,
      {
        "X-Credits-Charged" => ["12x"],
        "X-Successful-Record" => ["3"]
      }
    )

    expect(metadata.credits_charged).to be_nil
    expect(metadata.successful_records).to eq(3)
    expect(metadata.status_code).to eq(200)
    expect(metadata.duration_ms).to eq(14)
  end

  it "keeps optional arrays nil when filtered responses omit them" do
    response = described_class.parse_single_lookup(
      JSON.generate(
        {
          "country_metadata" => {
            "calling_code" => "+1"
          },
          "security" => {
            "threat_score" => 99,
            "is_vpn" => false
          }
        }
      )
    )

    expect(response.country_metadata.languages).to be_nil
    expect(response.security.proxy_provider_names).to be_nil
    expect(response.security.vpn_provider_names).to be_nil
  end
end
