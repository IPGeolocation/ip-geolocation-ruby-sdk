require "json"
require "spec_helper"

RSpec.describe "live integration" do
  run_live = ENV.fetch("IPGEO_RUN_LIVE_TESTS", "").downcase == "true"
  free_key = ENV["IPGEO_FREE_KEY"]
  paid_key = ENV["IPGEO_PAID_KEY"]
  request_origin = ENV["IPGEO_REQUEST_ORIGIN"]
  test_ip = "8.8.8.8"

  before do
    skip "Set IPGEO_RUN_LIVE_TESTS=true, IPGEO_FREE_KEY, and IPGEO_PAID_KEY to enable live tests" unless run_live && free_key && paid_key
  end

  it "free plan base lookup works" do
    client = IpgeolocationSdk::IpGeolocationClient.new(api_key: free_key, connect_timeout: live_connect_timeout, read_timeout: live_read_timeout)

    begin
      response = client.lookup_ip_geolocation(ip: test_ip)

      expect(response.data.ip).to eq(test_ip)
      expect(response.data.asn).not_to be_nil
      expect(response.data.network).to be_nil
      expect(response.data.company).to be_nil
      expect(response.data.time_zone).not_to be_nil
      expect(response.data.time_zone.current_tz_abbreviation).not_to be_nil
      expect(response.data.time_zone.current_tz_full_name).not_to be_nil
      expect(response.metadata.credits_charged || 0).to be >= 1
    ensure
      client.close
    end
  end

  it "free plan domain lookup is rejected" do
    client = IpgeolocationSdk::IpGeolocationClient.new(api_key: free_key, connect_timeout: live_connect_timeout, read_timeout: live_read_timeout)

    begin
      expect do
        client.lookup_ip_geolocation(ip: "ipgeolocation.io")
      end.to raise_error(IpgeolocationSdk::UnauthorizedError) { |error| expect(error.status_code).to eq(401) }
    ensure
      client.close
    end
  end

  [
    "security",
    "abuse",
    "user_agent",
    "geo_accuracy",
    "dma_code",
    "hostname",
    "liveHostname",
    "hostnameFallbackLive"
  ].each do |include_value|
    it "free plan rejects #{include_value}" do
      client = IpgeolocationSdk::IpGeolocationClient.new(api_key: free_key, connect_timeout: live_connect_timeout, read_timeout: live_read_timeout)

      begin
        expect do
          client.lookup_ip_geolocation(ip: test_ip, include: [include_value])
        end.to raise_error(IpgeolocationSdk::UnauthorizedError) { |error| expect(error.status_code).to eq(401) }
      ensure
        client.close
      end
    end
  end

  it "free plan include star returns the default response without additional modules" do
    client = IpgeolocationSdk::IpGeolocationClient.new(api_key: free_key, connect_timeout: live_connect_timeout, read_timeout: live_read_timeout)

    begin
      response = client.lookup_ip_geolocation(ip: test_ip, include: ["*"])

      expect(response.data.ip).to eq(test_ip)
      expect(response.data.security).to be_nil
      expect(response.data.abuse).to be_nil
      expect(response.data.user_agent).to be_nil
      expect(response.data.hostname).to be_nil
    ensure
      client.close
    end
  end

  it "free plan bulk is rejected" do
    client = IpgeolocationSdk::IpGeolocationClient.new(api_key: free_key, connect_timeout: live_connect_timeout, read_timeout: live_read_timeout)

    begin
      expect do
        client.bulk_lookup_ip_geolocation(ips: [test_ip])
      end.to raise_error(IpgeolocationSdk::UnauthorizedError)
    ensure
      client.close
    end
  end

  it "paid plan security and abuse work" do
    client = IpgeolocationSdk::IpGeolocationClient.new(api_key: paid_key, connect_timeout: live_connect_timeout, read_timeout: live_read_timeout)

    begin
      response = client.lookup_ip_geolocation(ip: test_ip, include: ["security", "abuse"])

      expect(response.data.security).not_to be_nil
      expect(response.data.abuse).not_to be_nil
      expect(response.metadata.credits_charged || 0).to be >= 4
    ensure
      client.close
    end
  end

  ["security", "abuse"].each do |field_name|
    it "paid plan still requires include for #{field_name}" do
      client = IpgeolocationSdk::IpGeolocationClient.new(api_key: paid_key, connect_timeout: live_connect_timeout, read_timeout: live_read_timeout)

      begin
        response = client.lookup_ip_geolocation(ip: test_ip, fields: [field_name])

        expect(response.data.public_send(field_name)).to be_nil
        expect(response.data.location).not_to be_nil
        expect(response.metadata.credits_charged).to eq(1)
      ensure
        client.close
      end
    end
  end

  it "paid plan bulk mixed lookup returns success and error items" do
    client = IpgeolocationSdk::IpGeolocationClient.new(api_key: paid_key, connect_timeout: live_connect_timeout, read_timeout: live_read_timeout)

    begin
      response = client.bulk_lookup_ip_geolocation(ips: [test_ip, "invalid-ip"])

      expect(response.data.length).to eq(2)
      expect(response.data[0]).to be_a(IpgeolocationSdk::BulkLookupSuccess)
      expect(response.data[0].data.ip).to eq(test_ip)
      expect(response.data[1]).to be_a(IpgeolocationSdk::BulkLookupError)
      expect(response.data[1].error.message).not_to be_nil
    ensure
      client.close
    end
  end

  it "paid plan rejects XML output on typed methods" do
    client = IpgeolocationSdk::IpGeolocationClient.new(api_key: paid_key, connect_timeout: live_connect_timeout, read_timeout: live_read_timeout)

    begin
      expect do
        client.lookup_ip_geolocation(ip: test_ip, output: IpgeolocationSdk::ResponseFormat::XML)
      end.to raise_error(IpgeolocationSdk::ValidationError, /XML output is not supported/)
    ensure
      client.close
    end
  end

  it "paid plan user-agent include reflects the request user_agent override" do
    client = IpgeolocationSdk::IpGeolocationClient.new(api_key: paid_key, connect_timeout: live_connect_timeout, read_timeout: live_read_timeout)

    begin
      default_response = client.lookup_ip_geolocation(ip: test_ip, include: ["user_agent"])
      override_user_agent = "ipgeolocation-ruby-sdk-live-test/2.0.0"
      override_response = client.lookup_ip_geolocation(
        ip: test_ip,
        include: ["user_agent"],
        user_agent: override_user_agent
      )

      expect(default_response.data.user_agent).not_to be_nil
      expect(default_response.data.user_agent.user_agent_string).not_to be_nil
      expect(override_response.data.user_agent).not_to be_nil
      expect(override_response.data.user_agent.user_agent_string).to eq(override_user_agent)
      expect(override_response.data.user_agent.user_agent_string).not_to eq(default_response.data.user_agent.user_agent_string)
    ensure
      client.close
    end
  end

  it "paid plan raw methods return XML when requested" do
    client = IpgeolocationSdk::IpGeolocationClient.new(api_key: paid_key, connect_timeout: live_connect_timeout, read_timeout: live_read_timeout)

    begin
      single = client.lookup_ip_geolocation_raw(ip: test_ip, output: IpgeolocationSdk::ResponseFormat::XML)
      bulk = client.bulk_lookup_ip_geolocation_raw(
        ips: [test_ip, "invalid-ip"],
        output: IpgeolocationSdk::ResponseFormat::XML
      )

      expect(single.data).to include("<")
      expect(bulk.data).to include("<")
    ensure
      client.close
    end
  end

  it "paid plan request_origin auth works without api_key" do
    skip "Set IPGEO_REQUEST_ORIGIN to an allowlisted origin to enable this test" unless request_origin

    client = IpgeolocationSdk::IpGeolocationClient.new(request_origin: request_origin, connect_timeout: live_connect_timeout, read_timeout: live_read_timeout)

    begin
      response = client.lookup_ip_geolocation(ip: test_ip)
      expect(response.data.ip).to eq(test_ip)
      expect(response.metadata.credits_charged || 0).to be >= 1
    ensure
      client.close
    end
  end

  def live_connect_timeout
    15
  end

  def live_read_timeout
    45
  end
end
