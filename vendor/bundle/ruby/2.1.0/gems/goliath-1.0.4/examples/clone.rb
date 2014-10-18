#!/usr/bin/env ruby
$:<< '../lib' << 'lib'

require 'goliath'

class RandomAPI2 < Goliath::API
  use Goliath::Rack::Params
  use Goliath::Rack::Validation::Param, :key => 'user'

  def response(env)
    [200, {}, "Hello 2!"]
  end
end

class Router < Goliath::API
  map '/', RandomAPI2
end

# class PlainApi < Goliath::API
#   use Goliath::Rack::Params
#   use Goliath::Rack::Validation::Param, :key => 'user'

#   def response(env)
#     [200, {}, "Hello 2!"]
#   end
# end