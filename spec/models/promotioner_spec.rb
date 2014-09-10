require 'spec_helper'

class Request
attr_reader :params
	def initialize
      @params = Hash.new
	  @params[:username] = "1212"
	  @params[:password] = "1212"
    end

	class Env
		def REMOTE_ADDR
			return "192.168.1.1"
		end
	end

	def env
		return Env.new
	end

end

describe Promotioner do
	before(:each) do
	   	@promotioner = FactoryGirl.create(:promotioner, :promotioner_with_login)
	   	@request = Request.new
	end
	it 'Login: correct username and password' do
		promotioner = Promotioner.login(@request)
		expect(promotioner.class).to eq(Promotioner)
		expect(promotioner.current_sign_in_ip).to eq("192.168.1.1")
	end

	it 'Login: invalid username' do
		@request.params[:username] = "1313"
		promotioner = Promotioner.login(@request)
		expect(promotioner).to eq(nil)
	end

	it 'Login: invalid password' do
		@request.params[:password] = "1313"

		5.times.each_with_index {|index|
			promotioner = Promotioner.login(@request)
			expect(promotioner).to eq(nil)
			expect(Promotioner.first.failed_attempts).to eq(index+1)
		}
	end

	it 'Generate access token: no access token exsit' do
		access_token = @promotioner.generate_access_token
		expect(access_token.class).to eq(PromotionerToken)
		expect(access_token.token.length).to eq(36)
		expect(access_token.key.length).to eq(22)
	end

	it 'Generate access token: access token exsit than before' do
		before_access_token = PromotionerToken.create(
			:promotioner_id => @promotioner.id,
			:token => SecureRandom.uuid,
			:key => SecureRandom.urlsafe_base64
		)
		access_token = @promotioner.generate_access_token
		expect(access_token.promotioner_id).to eq(@promotioner.id)
		expect(access_token.token).not_to eq(before_access_token.token)
		expect(access_token.key).not_to eq(before_access_token.key)
	end

end