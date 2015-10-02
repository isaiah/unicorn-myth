# run in jruby-1.7.0, looks like jruby-9.0.0.0 is more tolerant to thread
# unsafety as MRI now.

def not_thread_safe
  x = 0
  t = []
  100.times do |i|
    t << Thread.new {
      x += i
    }
  end
  t.map(&:join)
  puts x
end

if __FILE__ == $0
  not_thread_safe
end
