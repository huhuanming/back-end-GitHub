require 'em-synchrony/em-http'
require 'goliath/test_helper'
require 'yajl/json_gem'
require 'pp'
require 'active_record'
require 'mysql2'
require 'database_cleaner'
require 'factory_girl'
require File.join(File.dirname(__FILE__), '../', 'server')

Dir[File.expand_path('../../../lib/base_user/*.rb', __FILE__)].each {|lib| require lib }
Dir[File.expand_path('../../app/apis/helpers/*.rb', __FILE__)].each {|helper| require helper }
Dir[File.expand_path('../../app/models/*.rb', __FILE__)].each {|model| require model }
Dir[File.expand_path('../../app/apis/restfuls/*.rb', __FILE__)].each {|route| require route }
Dir[File.expand_path('../../app/apis/restfuls/v1/*.rb', __FILE__)].each {|api| require api }
Dir[File.expand_path('../../app/apis/entities/*.rb', __FILE__)].each {|entity| require entity }
Dir[File.expand_path('../../spec/factories/*.rb', __FILE__)].each {|factory| require factory }
Goliath.env = :test

RSpec.configure do |config|
  config.include Goliath::TestHelper, :example_group => {
    :file_path => /spec\//
  }
  config.include FactoryGirl::Syntax::Methods
  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end
  config.before(:each) do
    DatabaseCleaner.start
  end
  config.after(:each) do
    DatabaseCleaner.clean
  end

  ActiveRecord::Base.establish_connection(:adapter => "em_mysql2", 
                                       :database => "ebdb_test",
                                       :host => "localhost",
                                       :port => 3306,
                                       :pool => 5,
                                       :username => "root",
                                       :password => "lib217217")
end

def config_file
  File.expand_path(File.join(File.dirname(__FILE__), '..', 'config', 'app.rb'))
end


def generate_access_token(access_token)
  generate_access_token_with_TTL(access_token, 300)
end

def generate_access_token_with_TTL(access_token, ttl)
  token = access_token.token
  key = access_token.key
  data = Hash.new
  data[:deadline] = Time.now.to_i + ttl
  data[:device] = 0
  encoded = CGI::escape(data.to_json)
  encode_signed = CGI.escape(Base64.encode64(OpenSSL::HMAC.digest('sha1', key, encoded)).chomp)
  return token<<":"<<encode_signed<<":"<<encoded
end

class HelperInstance
  include ApiHelper
	attr_accessor :params

	def self.build_parmas(params)
			helper = self.new
			helper.params = params
			return helper
	end

	def error!(alert, status_code)
		raise ""<<status_code.to_s<<": "<<alert
	end
end