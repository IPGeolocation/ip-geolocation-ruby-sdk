require "spec_helper"

RSpec.describe "IpgeolocationSdk public API" do
  it "exposes the current gem version" do
    expect(IpgeolocationSdk::VERSION).to eq("2.0.0")
  end

  it "serializes value objects through the module helpers" do
    value = IpgeolocationSdk::IpGeolocationResponse.new(
      ip: "8.8.8.8",
      hostname: nil
    )

    expect(IpgeolocationSdk.to_json(value)).to eq("{\"ip\":\"8.8.8.8\"}")
    expect(IpgeolocationSdk.to_pretty_json(value, :full)).to include("\"hostname\": null")
  end

  it "exposes success helpers on bulk results" do
    success = IpgeolocationSdk::BulkLookupSuccess.new(
      data: IpgeolocationSdk::IpGeolocationResponse.new(ip: "8.8.8.8")
    )
    error = IpgeolocationSdk::BulkLookupError.new(
      error: IpgeolocationSdk::BulkLookupErrorDetails.new(message: "Invalid IP")
    )

    expect(success.success?).to eq(true)
    expect(success.data.ip).to eq("8.8.8.8")
    expect(error.success?).to eq(false)
    expect(error.error.message).to eq("Invalid IP")
  end
end
