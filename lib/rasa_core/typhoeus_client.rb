module RasaCore
  module TyphoeusClient
    def run_request(args={})
      request = Typhoeus::Request.new(args[:url],
        method: args[:method] || 'get',
        body: args[:body] || '',
        headers:args[:headers] || {'Content-Type': 'application/json'})
        request.run
        request.response
    end
  end
end
