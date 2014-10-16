require 'spec_helper'

describe ApplicationApi do
  let(:api_options) { { :config => config_file } }

  it '/v1/users/mobile_verification_code' do
    with_api(ApplicationApi, api_options) do
      params = Hash.new
      params[:phone_number] = "12345678910"
      get_request(:path => '/v1/users/mobile_verification_code', :body => params) do |async|
        response = JSON.parse(async.response)
        expect(response['response_status']).to eq("success to get it and please note that check your mobile phone")
        the_mobile_verification = UserMobileVerification.find_by(:phone_number => "12345678910")
        expect(the_mobile_verification.sent_attempts).to eq(1)
        expect(the_mobile_verification.failed_attempts).to eq(0)
        expect(the_mobile_verification.verification_code.length).to eq(6)
      end
    end
  end

  it 'Get mobile_verification_code again at once /v1/users/mobile_verification_code' do
    with_api(ApplicationApi, api_options) do
      params = Hash.new
      params[:phone_number] = "12345678910"
      get_request(:path => '/v1/users/mobile_verification_code', :body => params) do |async|
        response = JSON.parse(async.response)
        the_mobile_verification = UserMobileVerification.find_by(:phone_number => "12345678910")
        expect(the_mobile_verification.sent_attempts).to eq(1)
        expect(the_mobile_verification.verification_code.length).to eq(6)
        expect(response['response_status']).to eq("success to get it and please note that check your mobile phone")
          get_request(:path => '/v1/users/mobile_verification_code', :body => params) do |async|
            response = JSON.parse(async.response)
            expect(response['error']).to eq("Wait 1 minute to get verification_code")
            the_mobile_verification = UserMobileVerification.find_by(:phone_number => "12345678910")
            expect(the_mobile_verification.sent_attempts).to eq(1)
            expect(the_mobile_verification.failed_attempts).to eq(0)
            expect(the_mobile_verification.verification_code.length).to eq(6)
          end
      end
    end
  end

  it 'Wait a minute and get mobile_verification_code again /v1/users/mobile_verification_code' do
    with_api(ApplicationApi, api_options) do
      params = Hash.new
      params[:phone_number] = "12345678910"
      get_request(:path => '/v1/users/mobile_verification_code', :body => params) do |async|
        response = JSON.parse(async.response)
        the_mobile_verification = UserMobileVerification.find_by(:phone_number => "12345678910")
        expect(the_mobile_verification.sent_attempts).to eq(1)
        expect(the_mobile_verification.verification_code.length).to eq(6)
        expect(response['response_status']).to eq("success to get it and please note that check your mobile phone")
          sleep(1.minutes)
          get_request(:path => '/v1/users/mobile_verification_code', :body => params) do |async|
            response = JSON.parse(async.response)
            the_mobile_verification = UserMobileVerification.find_by(:phone_number => "12345678910")
            expect(the_mobile_verification.sent_attempts).to eq(2)
            expect(the_mobile_verification.verification_code.length).to eq(6)
            expect(response['response_status']).to eq("success to get it and please note that check your mobile phone")
          end
      end
    end
  end

end
