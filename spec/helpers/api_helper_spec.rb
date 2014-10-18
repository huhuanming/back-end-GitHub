require 'spec_helper'

class ApiHelperInstance < HelperInstance
end

describe ApiHelper do
  	before(:each) do
      @promotioner = FactoryGirl.create(:promotioner, :promotioner_with_login)
      @promotioner_token = @promotioner.generate_access_token
      @promotioner_access_token = generate_access_token(@promotioner_token)

      @restaurant = FactoryGirl.create(:restaurant, promotioner_id: @promotioner.id)
      
      @supervisor = FactoryGirl.create(:supervisor, :supervisor_with_login, restaurant_id: @restaurant.id)      
      @supervisor_token = @supervisor.generate_access_token
      @supervisor_access_token = generate_access_token(@supervisor_token)
  	end
	# authenticate_promotioner!
	it 'PromotionerAccessToken is invalid: only number' do
		params = Hash.new
		params[:access_token] = "2123123"
		begin
			ApiHelperInstance.build_parmas(params).authenticate_promotioner!
		rescue Exception => e
			expect(e.to_s).to eq("401: AccessToken is invalid")
		end
	end

	it 'PromotionerAccessToken is invalid: array length not equal 3' do
		params = Hash.new
		params[:access_token] = "2123123:1231231"
		begin
			ApiHelperInstance.build_parmas(params).authenticate_promotioner!
		rescue Exception => e
			expect(e.to_s).to eq("401: AccessToken is invalid")
		end
	end

	it 'PromotionerAccessToken is invalid: encoded params is invalid' do
		params = Hash.new
		params[:access_token] = "2123123:1231231:asdada"
		begin
			ApiHelperInstance.build_parmas(params).authenticate_promotioner!
		rescue Exception => e
			expect(e.to_s).to eq("401: AccessToken is invalid")
		end
	end

	it 'PromotionerAccessToken is invalid: deadline is invalid' do
		params = Hash.new
		params[:access_token] = "2123123:1231231:%7B%22deadline%22%3A1407837500%7D"
		begin
			ApiHelperInstance.build_parmas(params).authenticate_promotioner!
		rescue Exception => e
			expect(e.to_s).to eq("401: AccessToken is invalid, deadline is timeout")
		end
	end

	it 'PromotionerAccessToken is invalid: accessToken is not exsit' do
		params = Hash.new
		data = {
        	'deadline' => Time.new.to_i + 4000
     	 }
      	encoded = CGI::escape(data.to_json)
     	access_token = "2123123:1231231:" + encoded
     	params[:access_token] = access_token
		begin
			ApiHelperInstance.build_parmas(params).authenticate_promotioner!
		rescue Exception => e
			expect(e.to_s).to eq("404: AccessToken is not found")
		end
	end

	it 'PromotionerAccessToken is invalid: encode_signed is invalid' do
		params = Hash.new
		data = {
        	'deadline' => Time.new.to_i + 4000
     	 }
     	token = PromotionerToken.first.token
      	encoded = CGI::escape(data.to_json)
     	access_token = token + ":1231231:" + encoded
     	params[:access_token] = access_token
		begin
			ApiHelperInstance.build_parmas(params).authenticate_promotioner!
		rescue Exception => e
			expect(e.to_s).to eq("401: AccessToken is invalid")
		end
	end

	it 'PromotionerAccessToken is valid' do
		params = Hash.new
		data = {
        	'deadline' => Time.new.to_i + 4000
     	 }
     	p = PromotionerToken.first
     	token = p.token
      	encoded = CGI::escape(data.to_json)
     	encoded_sign = CGI.escape(Base64.encode64(OpenSSL::HMAC.digest('sha1', p.key, encoded)).chomp)
		access_token = ""
      	access_token << token << ":" << encoded_sign << ":" << encoded 
        params[:access_token] = access_token
		begin
			ApiHelperInstance.build_parmas(params).authenticate_promotioner!
		rescue Exception => e
			expect(e.to_s).to eq("401: AccessToken is invalid")
			expect(e.to_s).to eq("401: AccessToken is not exsit")
			expect(e.to_s).to eq("401: AccessToken is invalid, deadline is timeout")
		end
	end

	# current_promotioner
	it 'token is valid' do
		params = Hash.new
		data = {
        	'deadline' => Time.new.to_i + 4000
     	 }
     	p = PromotionerToken.first
     	token = p.token
      	encoded = CGI::escape(data.to_json)
     	encoded_sign = CGI.escape(Base64.encode64(OpenSSL::HMAC.digest('sha1', p.key, encoded)).chomp)
		access_token = ""
      	access_token << token << ":" << encoded_sign << ":" << encoded 
        params[:access_token] = access_token
		begin
			expect(ApiHelperInstance.build_parmas(params).current_promotioner).not_to eq(nil)
		rescue Exception => e
			expect(e.to_s).to eq("401: Promotioner is not exsit")
		end
	end


	# authenticate_supervisor!
	it 'SupervisorAccessToken is invalid: only number' do
		params = Hash.new
		params[:access_token] = "2123123"
		begin
			ApiHelperInstance.build_parmas(params).authenticate_supervisor!
		rescue Exception => e
			expect(e.to_s).to eq("401: AccessToken is invalid")
		end
	end

	it 'SupervisorAccessToken is invalid: array length not equal 3' do
		params = Hash.new
		params[:access_token] = "2123123:1231231"
		begin
			ApiHelperInstance.build_parmas(params).authenticate_supervisor!
		rescue Exception => e
			expect(e.to_s).to eq("401: AccessToken is invalid")
		end
	end

	it 'SupervisorAccessToken is invalid: encoded params is invalid' do
		params = Hash.new
		params[:access_token] = "2123123:1231231:asdada"
		begin
			ApiHelperInstance.build_parmas(params).authenticate_supervisor!
		rescue Exception => e
			expect(e.to_s).to eq("401: AccessToken is invalid")
		end
	end

	it 'SupervisorAccessToken is invalid: deadline is invalid' do
		params = Hash.new
		params[:access_token] = "2123123:1231231:%7B%22deadline%22%3A1407837500%7D"
		begin
			ApiHelperInstance.build_parmas(params).authenticate_supervisor!
		rescue Exception => e
			expect(e.to_s).to eq("401: AccessToken is invalid, deadline is timeout")
		end
	end

	it 'SupervisorAccessToken is invalid: accessToken is not exsit' do
		params = Hash.new
		data = {
        	'deadline' => Time.new.to_i + 4000
     	 }
      	encoded = CGI::escape(data.to_json)
     	access_token = "2123123:1231231:" + encoded
     	params[:access_token] = access_token
		begin
			ApiHelperInstance.build_parmas(params).authenticate_supervisor!
		rescue Exception => e
			expect(e.to_s).to eq("404: AccessToken is not found")
		end
	end

	it 'SupervisorAccessToken is invalid: encode_signed is invalid' do
		params = Hash.new
		data = {
        	'deadline' => Time.new.to_i + 4000
     	 }
     	token = SupervisorToken.first.token
      	encoded = CGI::escape(data.to_json)
     	access_token = token + ":1231231:" + encoded
     	params[:access_token] = access_token
		begin
			ApiHelperInstance.build_parmas(params).authenticate_supervisor!
		rescue Exception => e
			expect(e.to_s).to eq("401: AccessToken is invalid")
		end
	end

	it 'SupervisorAccessToken is valid' do
		params = Hash.new
		data = {
        	'deadline' => Time.new.to_i + 4000
     	 }
     	p = SupervisorToken.first
     	token = p.token
      	encoded = CGI::escape(data.to_json)
     	encoded_sign = CGI.escape(Base64.encode64(OpenSSL::HMAC.digest('sha1', p.key, encoded)).chomp)
		access_token = ""
      	access_token << token << ":" << encoded_sign << ":" << encoded 
        params[:access_token] = access_token
		begin
			ApiHelperInstance.build_parmas(params).authenticate_supervisor!
		rescue Exception => e
			expect(e.to_s).to eq("401: AccessToken is invalid")
			expect(e.to_s).to eq("401: AccessToken is not exsit")
			expect(e.to_s).to eq("401: AccessToken is invalid, deadline is timeout")
		end
	end

	# current_supervisor
	it 'supervisor token is valid' do
		params = Hash.new
		data = {
        	'deadline' => Time.new.to_i + 4000
     	 }
     	p = SupervisorToken.first
     	token = p.token
      	encoded = CGI::escape(data.to_json)
     	encoded_sign = CGI.escape(Base64.encode64(OpenSSL::HMAC.digest('sha1', p.key, encoded)).chomp)
		access_token = ""
      	access_token << token << ":" << encoded_sign << ":" << encoded 
        params[:access_token] = access_token
		begin
			expect(ApiHelperInstance.build_parmas(params).current_supervisor).not_to eq(nil)
		rescue Exception => e
			expect(e.to_s).to eq("401: Supervisor is not exsit")
		end
	end
end
