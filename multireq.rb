require 'net/http'

uri = URI('http://localhost:9292/users')

10.times { |i|
  puts i
  5.times.map {
    Thread.new { Net::HTTP.get_response(uri) }
  }.each(&:join)
}
