module RasaCore
  module ResponseFormatter
    def format_response_body(body, frmt)
      if [:no_format, :json].include?(frmt)
        body
      else
        JSON.parse(body || '{}', object_class: OpenStruct)
      end
    end
  end
end
