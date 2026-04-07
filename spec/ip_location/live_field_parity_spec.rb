require "bigdecimal"
require "json"
require "spec_helper"

RSpec.describe "live field parity" do
  run_live_hardening = ENV.fetch("IPGEO_RUN_LIVE_HARDENING", "").downcase == "true"
  paid_key = ENV["IPGEO_PAID_KEY"]

  before do
    skip "Set IPGEO_RUN_LIVE_HARDENING=true and IPGEO_PAID_KEY to enable live field parity tests" unless run_live_hardening && paid_key
  end

  it "include star response matches the typed model" do
    assert_single_lookup_parity(ip: "8.8.8.8", include: ["*"])
  end

  it "geo accuracy and dma response matches the typed model" do
    assert_single_lookup_parity(ip: "8.8.8.8", include: ["geo_accuracy", "dma_code"])
  end

  it "domain lookup response matches the typed model" do
    assert_single_lookup_parity(ip: "ipgeolocation.io", include: ["hostnameFallbackLive"])
  end

  it "security abuse and user-agent response matches the typed model" do
    assert_single_lookup_parity(
      ip: "8.8.8.8",
      include: ["security", "abuse", "user_agent"],
      user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/601.3.9 (KHTML, like Gecko) Version/9.0.2 Safari/601.3.9"
    )
  end

  it "filtered security response matches the typed model" do
    assert_single_lookup_parity(
      ip: "8.8.8.8",
      include: ["security"],
      fields: ["location.city", "security.threat_score", "security.is_vpn"]
    )
  end

  it "filtered country metadata response matches the typed model" do
    assert_single_lookup_parity(
      ip: "8.8.8.8",
      fields: ["country_metadata.calling_code"]
    )
  end

  it "bulk mixed response matches the typed model" do
    assert_bulk_lookup_parity(ips: ["8.8.8.8", "invalid-ip", "1.1.1.1"])
  end

  it "bulk filtered security response matches the typed model" do
    assert_bulk_lookup_parity(
      ips: ["8.8.8.8", "1.1.1.1"],
      include: ["security"],
      fields: ["location.city", "security.threat_score", "security.is_vpn"]
    )
  end

  def assert_single_lookup_parity(**request)
    client = IpgeolocationSdk::IpGeolocationClient.new(
      api_key: ENV.fetch("IPGEO_PAID_KEY"),
      connect_timeout: live_connect_timeout,
      read_timeout: live_read_timeout
    )

    begin
      raw = client.lookup_ip_geolocation_raw(request)
      typed = client.lookup_ip_geolocation(request)

      raw_node = JSON.parse(raw.data)
      typed_node = JSON.parse(IpgeolocationSdk.to_json(typed.data))
      assert_json_exact(raw_node, typed_node, "$")
    ensure
      client.close
    end
  end

  def assert_bulk_lookup_parity(**request)
    client = IpgeolocationSdk::IpGeolocationClient.new(
      api_key: ENV.fetch("IPGEO_PAID_KEY"),
      connect_timeout: live_connect_timeout,
      read_timeout: live_read_timeout
    )

    begin
      raw = client.bulk_lookup_ip_geolocation_raw(request)
      typed = client.bulk_lookup_ip_geolocation(request)

      raw_array = JSON.parse(raw.data)
      expect(raw_array).to be_a(Array)
      expect(typed.data.length).to eq(raw_array.length)

      raw_array.each_with_index do |raw_item, index|
        typed_item = typed.data[index]
        expect(typed_item).not_to be_nil

        if typed_item.success?
          assert_json_exact(raw_item, JSON.parse(IpgeolocationSdk.to_json(typed_item.data)), "$[#{index}]")
        else
          expect(raw_item["message"]).to eq(typed_item.error.message)
        end
      end
    ensure
      client.close
    end
  end

  def assert_json_exact(raw_node, typed_node, path)
    if raw_node.nil?
      expect(typed_node).to be_nil, path
      return
    end

    expect(typed_node).not_to be_nil, path

    return if live_clock_field?(path)

    if raw_node.is_a?(Hash)
      expect(typed_node).to be_a(Hash), path

      raw_node.each do |key, value|
        child_path = "#{path}.#{key}"
        if !typed_node.key?(key) && omittable_empty_object?(value, child_path)
          next
        end

        expect(typed_node.key?(key)).to eq(true), child_path
        assert_json_exact(value, typed_node[key], child_path)
      end

      extra_keys = typed_node.keys - raw_node.keys
      expect(extra_keys).to eq([]), "#{path} unexpected keys"
      return
    end

    if raw_node.is_a?(Array)
      expect(typed_node).to be_a(Array), path
      expect(typed_node.length).to eq(raw_node.length), "#{path} size"
      raw_node.each_with_index do |item, index|
        assert_json_exact(item, typed_node[index], "#{path}[#{index}]")
      end
      return
    end

    if raw_node.is_a?(Numeric) && typed_node.is_a?(Numeric)
      expect(BigDecimal(typed_node.to_s)).to eq(BigDecimal(raw_node.to_s)), path
      return
    end

    expect(typed_node).to eq(raw_node), path
  end

  def live_clock_field?(path)
    path.end_with?(".time_zone.current_time") || path.end_with?(".time_zone.current_time_unix")
  end

  def omittable_empty_object?(raw_node, path)
    raw_node == {} && (path.end_with?(".time_zone.dst_start") || path.end_with?(".time_zone.dst_end"))
  end

  def live_connect_timeout
    15
  end

  def live_read_timeout
    45
  end
end
