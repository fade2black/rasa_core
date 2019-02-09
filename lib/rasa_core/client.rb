class RasaCore::Client
  include RasaCore::TyphoeusClient
  include RasaCore::ResponseFormatter

  def initialize(args={})
    @server = args[:server]
    @port = args[:port]
  end

  def check_health
    build_response(run_request(url: build_url), :no_format)
  end

  def version
    response = run_request(url: build_url(path: 'version'))
    build_response(response)
  end

  def status
    response = run_request(url: build_url(path: 'status'))
    build_response(response)
  end

  def send_message(args={})
    path = "webhooks/rest/webhook"
    body = {sender: args[:sender_id] || 'default', message: args[:message]}
    response = run_request(url: build_url(path: path), body: body, method: 'post')
    build_response(response)
  end

  private
  def build_url(args={})
    "#{@server}:#{@port}/#{args[:path]}#{build_url_query(args[:query])}"
  end

  def build_url_query(query)
    q = URI.encode_www_form(query || {})
    q.empty? ? "" : '?'+q
  end


  def build_response(response, frmt=nil)
    body = response.body
    body = format_response_body(body, frmt) if response.success?
    {
      success: response.success?,
      timed_out: response.timed_out?,
      return_message: response.return_message,
      code: response.code,
      body: body
    }
  end
end
