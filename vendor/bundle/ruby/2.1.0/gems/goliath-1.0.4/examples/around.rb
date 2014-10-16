#!/usr/bin/env ruby
$:<< '../lib' << 'lib'

require 'goliath'

class ApiValidationAroundware
  include Goliath::Rack::SimpleAroundware
  class InvalidApiKeyError < Goliath::Validation::BadRequestError; end
  
  def pre_process
    validate_api_key!
    env.logger.info "past api_key validation" #<-- this is output, then an empty response header & body as if it is just hanging...
    Goliath::Connection::AsyncResponse
  end 
  
  def post_process
    [status, headers, body]
  end
  
  def validate_api_key!
    server_api_key = env['config']['server_api_key'].to_s
    if api_key != server_api_key
      raise InvalidApiKeyError
    end
  end

  # retreive the client's api_key  
  def api_key
    env['HTTP_API_KEY'].to_s
  end
end

class AwesomeApiWithLogging < Goliath::API
  use Goliath::Rack::SimpleAroundwareFactory, ApiValidationAroundware
  def response(env)
    [200, {}, "Hello"]
  end
end
