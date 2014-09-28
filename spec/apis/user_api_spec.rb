require 'spec_helper'

describe ApplicationApi do
  let(:api_options) { { :config => config_file } }
  before(:each) do
      this_time = Time.new
      @user_mobile_verification = FactoryGirl.create(:user_mobile_verification, created_at: this_time, updated_at: this_time)
  end

  it 'wrong phone number /v1/users' do
    with_api(ApplicationApi, api_options) do
      params = Hash.new
      params[:phone_number] = "1234567"
      params[:password] = "12345678910"
      params[:encryption_code] = "123456"
      post_request(:path => '/v1/users', :body => params) do |async|
          response = JSON.parse(async.response)
          expect(response['error']).to eq("Verification code is not found with the phone number")     
      end
    end
  end

  it 'wrong encryption_code: no colon /v1/users' do
    with_api(ApplicationApi, api_options) do
      params = Hash.new
      params[:phone_number] = "12345678910"
      params[:password] = "12345678910"
      params[:encryption_code] = "123456"
      post_request(:path => '/v1/users', :body => params) do |async|
          response = JSON.parse(async.response)
          expect(response['error']).to eq("Verification code is invalid")     
      end
    end
  end

  it 'encryption_code is invalid: two colon /v1/users' do
    with_api(ApplicationApi, api_options) do
      params = Hash.new
      params[:phone_number] = "12345678910"
      params[:password] = "12345678910"
      params[:encryption_code] = "123456:123:123"
      post_request(:path => '/v1/users', :body => params) do |async|
          response = JSON.parse(async.response)
          expect(response['error']).to eq("Verification code is invalid")     
      end
    end
  end

  it 'encryption_code is invalid: two colon /v1/users' do
    with_api(ApplicationApi, api_options) do
      params = Hash.new
      params[:phone_number] = "12345678910"
      params[:password] = "12345678910"
      params[:encryption_code] = "123456:123:123"
      post_request(:path => '/v1/users', :body => params) do |async|
          response = JSON.parse(async.response)
          expect(response['error']).to eq("Verification code is invalid")     
      end
    end
  end

  it 'encryption_code is valid: /v1/users' do
    with_api(ApplicationApi, api_options) do
      params = Hash.new
      params[:phone_number] = "12345678910"
      params[:password] = "12345678910"
      params[:encryption_code] = "6CDTnshG32dI9%2B%2FsQDr1lgW%2BTTE%3D:%7B%22device%22%3A2%2C%22deadline%22%3A1411897069%7D"
      post_request(:path => '/v1/users', :body => params) do |async|
          response = JSON.parse(async.response)
          expect(response['last_login_at'].nil?).to eq(false) 
          access_token = response['access_token']
          expect(access_token['token'].length).to eq(36) 
          expect(access_token['key'].length).to eq(22)     
      end
    end
  end


  it 'encryption_code is valid and login again: /v1/users' do
    with_api(ApplicationApi, api_options) do
      params = Hash.new
      params[:phone_number] = "12345678910"
      params[:password] = "12345678910"
      params[:encryption_code] = "6CDTnshG32dI9%2B%2FsQDr1lgW%2BTTE%3D:%7B%22device%22%3A2%2C%22deadline%22%3A1411897069%7D"
      post_request(:path => '/v1/users', :body => params) do |async|
          response = JSON.parse(async.response)
          expect(response['last_login_at'].nil?).to eq(false) 
          access_token = response['access_token']
          expect(access_token['token'].length).to eq(36) 
          expect(access_token['key'].length).to eq(22)

            params[:username] = "12345678910"
            post_request(:path => '/v1/users/login', :body => params) do |async|
                response = JSON.parse(async.response)
                expect(response['last_login_at'].nil?).to eq(false) 
                access_token = response['access_token']
                expect(access_token['token'].length).to eq(36) 
                expect(access_token['key'].length).to eq(22)     
            end     
      end
    end
  end
  


end
