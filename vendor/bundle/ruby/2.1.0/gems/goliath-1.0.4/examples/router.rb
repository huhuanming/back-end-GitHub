#!/usr/bin/env ruby
$:<< '../lib' << 'lib'

require 'goliath'
require 'test'


class Router < Goliath::API
  get '/v1/app/:appid/binary/:key', RawFileApp
  put '/v1/app/:appid/binary/:key', RawFileApp

  not_found do
    run Proc.new { |env| [404, {"Content-Type" => "text/html"}, "not found"] }
  end
end
