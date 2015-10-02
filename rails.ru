require "rails"
require "action_controller/railtie"

class MyApp < Rails::Application
  routes.append do
    get "/users" => "users#index"
  end

  # uncomment this line to utilize concurrency
  #config.middleware.delete "Rack::Lock" # <- I'm thread safe

  config.secret_token = "49837489qkuweoiuoqwehisuakshdjksadhaisdy78o34y138974xyqp9rmye8yrpiokeuioqwzyoiuxftoyqiuxrhm3iou1hrzmjk"
end
class ApplicationController < ActionController::Base; end

class UsersController < ApplicationController
  @counter = 0
  @mux = Mutex.new

  class << self
    attr_accessor :counter, :mux
  end

  trap(:INFO) {
    $stderr.puts "Count: #{UsersController.counter}"
  }

  def index
    # uncomment this block to enable the lock
    #self.class.mux.synchronize {
      counter = self.class.counter # read
      sleep(0.1)
      counter += 1                 # update
      sleep(0.1)
      self.class.counter = counter # write
    #}
    sleep(0.1) # some other expensive op

    render text: 'hello'
  end
end

MyApp.initialize!

run MyApp
