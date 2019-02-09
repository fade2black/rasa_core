module RasaCore
  module TyphoeusClient
    def run_request(args={})
      headers = {'Content-Type': 'application/json'}.merge(args[:headers] || {})
      request = Typhoeus::Request.new(args[:url],
        method: args[:method] || 'get',
        body: args[:body].to_json,
        headers: headers)

        request.run
        request.response
    end
  end
end
