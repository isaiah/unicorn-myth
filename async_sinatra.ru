require 'sinatra'
require 'sinatra/async'
require 'em-http-request'
require 'net/http'
require 'uri'

class App < Sinatra::Base
  register Sinatra::Async
  set :server, :thin

  aget "/" do
    EM.add_timer(1) { body "async hello world" }
  end

  get "/sync" do
    "sync hello world"
  end

  aget "/circle" do
    http = EM::HttpRequest.new("http://localhost:9292/sync").get

    http.errback do
      body("errored!")
    end

    http.callback do
      body(http.response + " and not blocked!")
    end
  end

  get "/sync_circle" do
    resp = Net::HTTP.get(URI("http://localhost:9292/sync"))
    resp.body + " blocked!"
  end
end

run App
