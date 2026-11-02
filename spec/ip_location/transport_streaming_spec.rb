require "spec_helper"
require "socket"

RSpec.describe IpgeolocationSdk::NetHttpTransport do
  let(:request) do
    IpgeolocationSdk::HttpRequestData.new(
      url: "http://127.0.0.1/v3/ipgeo",
      method: "GET", headers: {}, body: nil,
      connect_timeout: 1.0, read_timeout: 0.1
    )
  end

  def stream_response(chunks, limit: 100)
    response = instance_double("Net::HTTPResponse", code: "200", body: chunks.join, to_hash: {})
    allow(response).to receive(:read_body) do |&block|
      chunks.each { |chunk| block.call(chunk) }
    end
    http = instance_double("Net::HTTP")
    allow(Net::HTTP).to receive(:new).and_return(http)
    allow(http).to receive(:use_ssl=).with(false)
    allow(http).to receive(:open_timeout=).with(1.0)
    allow(http).to receive(:read_timeout=).with(0.1)
    allow(http).to receive(:request) do |_, &block|
      block.call(response) if block
      response
    end
    described_class.new(max_response_body_chars: limit).send_request(request).body
  end

  it "preserves UTF-8 characters split at every byte boundary" do
    text = "東京 café 😀\r\n"
    chunks = text.b.bytes.map { |byte| byte.chr(Encoding::BINARY) }

    expect(stream_response(chunks, limit: text.length)).to eq(text)
  end

  it "counts accumulated characters rather than bytes or individual chunks" do
    expect(stream_response(["東".b, "京".b], limit: 2)).to eq("東京")
    expect { stream_response(["東".b, "京".b, "!".b], limit: 2) }
      .to raise_error(IpgeolocationSdk::TransportError, "Response body exceeded max size of 2 characters")
  end

  it "replaces malformed and incomplete UTF-8 sequences" do
    expect(stream_response(["a\xFFb\xE6".b, "\x9D".b])).to eq("a\uFFFDb\uFFFD")
  end

  it "preserves valid text adjacent to consecutive malformed sequences" do
    bytes = [0x8d, 0xdf, 0x61].pack("C*")
    expect(stream_response([bytes])).to eq("\uFFFD\uFFFDa")
    expect(stream_response(bytes.bytes.map { |byte| byte.chr(Encoding::BINARY) })).to eq("\uFFFD\uFFFDa")
  end

  it "handles invalid UTF-8 prefixes without dropping following text" do
    [[0xe0, 0x80], [0xed, 0xa0], [0xf0, 0x80], [0xf4, 0x90]].each do |prefix|
      bytes = (prefix + [0x61]).pack("C*")
      expected = bytes.dup.force_encoding(Encoding::UTF_8).scrub
      expect(stream_response(bytes.bytes.map { |byte| byte.chr(Encoding::BINARY) })).to eq(expected)
    end
  end

  it "matches whole-body UTF-8 replacement for arbitrary bytes and chunk boundaries" do
    random = Random.new(1234)
    100.times do
      bytes = Array.new(random.rand(1..100)) { random.rand(256) }.pack("C*")
      chunks = []
      offset = 0
      while offset < bytes.bytesize
        chunk = bytes.byteslice(offset, random.rand(1..8))
        chunks << chunk
        offset += chunk.bytesize
      end
      expected = bytes.dup.force_encoding(Encoding::UTF_8).scrub
      expect(stream_response(chunks, limit: expected.length)).to eq(expected)
    end
  end

  it "includes the replacement for an incomplete final character in the limit" do
    expect { stream_response(["a\xE6\x9D".b], limit: 1) }
      .to raise_error(IpgeolocationSdk::TransportError, "Response body exceeded max size of 1 characters")
  end

  it "returns an empty UTF-8 string for a response with no body" do
    result = stream_response([])
    expect(result).to eq("")
    expect(result.encoding).to eq(Encoding::UTF_8)
  end

  it "stops an actual HTTP download at the cumulative limit and closes the connection" do
    server = TCPServer.new("127.0.0.1", 0)
    connection_closed = Queue.new
    worker = Thread.new do
      socket = server.accept
      while (line = socket.gets) && line != "\r\n"
      end
      socket.write("HTTP/1.1 200 OK\r\nTransfer-Encoding: chunked\r\nConnection: close\r\n\r\n")
      socket.write("2\r\nab\r\n2\r\ncd\r\n")
      connection_closed << (IO.select([socket], nil, nil, 2) && socket.read(1).nil?)
    ensure
      socket.close if socket && !socket.closed?
    end
    local_request = IpgeolocationSdk::HttpRequestData.new(
      url: "http://127.0.0.1:#{server.addr[1]}/v3/ipgeo",
      method: "GET", headers: {}, body: nil,
      connect_timeout: 1.0, read_timeout: 0.1
    )

    expect { described_class.new(max_response_body_chars: 3).send_request(local_request) }
      .to raise_error(IpgeolocationSdk::TransportError, "Response body exceeded max size of 3 characters")
    expect(worker.join(3)).not_to be_nil
    expect(connection_closed.pop).to be_truthy
  ensure
    server.close if server && !server.closed?
    worker.kill if worker && worker.alive?
    worker.join if worker
  end
end
