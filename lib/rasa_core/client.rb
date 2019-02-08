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

  def version
    create_response(run_request(url: url(path: 'version')))
  end

  def status
    create_response(run_request(url: url(path: 'status')))
  end

  private
  def url(args={})
    "#{@server}:#{@port}/#{args[:path]}"
  end

  def create_response(response, frmt=nil)
    {
      success: response.success?,
      timed_out: response.timed_out?,
      return_message: response.return_message,
      code: response.code,
      body: format_response_body(response.body, frmt)
    }
  end
end
