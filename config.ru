require 'em-http-request'

app = -> env do
  http = EM::HttpRequest.new("http://www.google.de").get
  http.callback do
    env['async.callback'].call([200, {}, "response status: #{http.response_header.status}"])
  end
  [-1, {}, []]
  #throw :async
end

run app
