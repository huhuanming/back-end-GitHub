#!/usr/bin/env ruby
$:<< '../lib' << 'lib'

require 'goliath'

class RawFileApp < Goliath::API
  use Goliath::Rack::Params                 # parse & merge query and body parameters
  use Goliath::Rack::DefaultMimeType        # cleanup accepted media types
  use Goliath::Rack::Formatters::JSON       # JSON output formatter
  use Goliath::Rack::Render                 # auto-negotiate response format

  def response(env)
    p params
    p params['key2']
    p params[:key2]
    obj = {
      somekey: 'val',
      otherkey: 42
    }
    [200, { 'Content-Type' => 'application/json' }, obj]
  end
end

class Router < Goliath::API
  get '/v1/app/:appid/binary/:key', RawFileApp
  put '/v1/app/:appid/binary/:key', RawFileApp

  not_found do
    run Proc.new { |env| [404, {"Content-Type" => "text/html"}, "not found"] }
  end
end
