require "spec_helper"
require "socket"
require "timeout"
require "uri"

RSpec.describe "Client HTTP requests" do
  def with_server(status, body)
    server = TCPServer.new("127.0.0.1", 0)
    port = server.addr[1]
    received = Queue.new
    worker = Thread.new do
      Timeout.timeout(5) do
        socket = server.accept
        begin
          request_line = socket.gets
          headers = {}
          while (line = socket.gets) && line != "\r\n"
            name, value = line.split(":", 2)
            headers[name.downcase] = value.strip
          end
          payload = socket.read(headers.fetch("content-length", "0").to_i)
          received << [request_line, headers, payload]
          socket.write("HTTP/1.1 #{status} Test\r\nContent-Type: application/json\r\nContent-Length: #{body.bytesize}\r\nConnection: close\r\n\r\n")
          socket.write(body)
        ensure
          socket.close
        end
      end
    end
    client = IpgeolocationSdk::IpGeolocationClient.new(api_key: "test-key+/value", base_url: "http://127.0.0.1:#{port}", read_timeout: 3)
    yield client
    worker.value
    received.pop
  ensure
    client&.close
    server&.close
    worker&.kill if worker&.alive?
    worker&.join
  end

  {
    lookup_ip_geolocation: { ip: "8.8.8.8" },
    lookup_ip_geolocation_raw: { ip: "8.8.8.8" },
    bulk_lookup_ip_geolocation: { ips: ["8.8.8.8"] },
    bulk_lookup_ip_geolocation_raw: { ips: ["8.8.8.8"] }
  }.each do |method, request|
    it "sends Arabic and the original key through #{method}" do
      bulk = method.to_s.start_with?("bulk")
      data = { ip: "8.8.8.8", location: { country_name: "الولايات المتحدة" } }
      body = JSON.generate(bulk ? [data] : data)
      request_line, headers, payload = with_server(200, body) do |client|
        result = client.public_send(method, request.merge(lang: IpgeolocationSdk::Language::AR))
        if method.to_s.end_with?("_raw")
          expect(result.data).to eq(body)
        else
          location = bulk ? result.data.first.data.location : result.data.location
          expect(location.country_name).to eq("الولايات المتحدة")
        end
      end
      verb, target = request_line.split(" ")
      uri = URI.parse(target)
      params = URI.decode_www_form(uri.query).to_h
      expect(verb).to eq(bulk ? "POST" : "GET")
      expect(uri.path).to eq(bulk ? "/v3/ipgeo-bulk" : "/v3/ipgeo")
      expect(params["apiKey"]).to eq("test-key+/value")
      expect(params["lang"]).to eq("ar")
      expect(headers["user-agent"]).to eq("ipgeolocation-ruby-sdk/2.0.2")
      expect(JSON.parse(payload)).to eq({ "ips" => ["8.8.8.8"] }) if bulk
    end

    it "preserves HTTP status and hides echoed keys through #{method}" do
      with_server(401, "<html>Rejected test-key+/value</html>") do |client|
        expect { client.public_send(method, request) }.to raise_error(IpgeolocationSdk::UnauthorizedError) do |error|
          expect(error.status_code).to eq(401)
          expect(error.api_message).to eq("<html>Rejected [REDACTED]</html>")
          expect(error.full_message).not_to include("test-key+/value")
        end
      end
    end
  end
end
