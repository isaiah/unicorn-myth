# The myth of Unicorn

Slides: http://www.slideshare.net/IsaiahPeng/the-myth-of-unicorn

Code samples of my talk on the [RUG::B meetup](http://www.rug-b.de/topics/slow-client-and-unicorn).

# Get started

```
bundle
# asynchronous rack demo
foreman start rack
curl http://localhost:9292
# asynchronous sinatra / circle request
foreman start async
curl http://localhost:9292/circle
# Thread unsafe rails demo
foreman start rails
ruby multireq.rb
# find puma pid by 
kill -INFO $(ps aux | grep puma | grep -v 'grep' | awk '{print $2}')
# check the output of the forman, it should print 50
# find more in [[rails.ru]]
```
