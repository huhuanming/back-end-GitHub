#!/usr/bin/env ruby
$:<< '../lib' << 'lib'

require 'goliath'

class Upload < Goliath::API
  
  def on_headers(env, h)
    if h['Expect'] == '100-continue'
      env.stream_send "HTTP/1.1 100 Continue\r\n"
    end
  end

  def response(env)
    [200, {}, "oh hai"]
  end
end
