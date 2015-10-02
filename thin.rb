# -*- coding: utf-8 -*-
class Thin::Connection < EM::Connection
  # When the request is received and parsed
  def receive_data(data)
    # anything happening here is blocking
    resp = @app.call(Request.new(data))
    # handoff to EventMachine, non-blocking 
    send_data resp.body.join(“”)
  end
end
