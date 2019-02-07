class RasaCore::Client
  include RasaCore::TyphoeusClient
  include RasaCore::ResponseFormatter

  def initialize(args={})
    @server = args[:server]
    @port = args[:port]
  end

  def check_health
    create_response(run_request(url: url), :no_format)
  end

  private
  def url
    "#{@server}:#{@port}"
  end

  def create_response(response, frmt)
    {
      success: response.success?,
      timed_out: response.timed_out?,
      return_message: response.return_message,
      code: response.code,
      body: format_response_body(response.body, frmt)
    }
  end
end
