require "rasa_core/typhoeus_client"
require "rasa_core/response_formatter"
require "rasa_core/client"

RSpec.describe RasaCore::Client do
  it "forms urls" do
    server = '172.1.2.3'
    port = 5005

    client = described_class.new(server: server, port: port)

    expect(client.send(:build_url)).to eq("#{server}:#{port}/")
    expect(client.send(:build_url, {path:'a_path'})).to eq("#{server}:#{port}/a_path")
    expect(client.send(:build_url, {path:'conversion', query:{param1:1, param2:'two'}})).to eq("#{server}:#{port}/conversion?param1=1&param2=two")
  end
end
