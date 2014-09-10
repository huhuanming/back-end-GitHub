require 'spec_helper'

describe ApplicationApi do
  let(:api_options) { { :config => config_file } }
  before(:each) do
      @promotioner = FactoryGirl.create(:promotioner, :promotioner_with_login)
  end
  it '/v1/promotioners/login: Username or password is invalid' do
    with_api(ApplicationApi, api_options) do
      params = Hash.new
      params[:username] = "91234999000"
      params[:password] = "2888"
      post_request(:path => '/v1/promotioners/login', :body => params) do |async|
        response = JSON.parse(async.response)
        expect(response['error']).to eq("Username or password is invalid")
      end
    end
  end

  it '/v1/promotioners/login: Username or password is valid' do
    with_api(ApplicationApi, api_options) do
      params = Hash.new
      params[:username] = "1212"
      params[:password] = "1212"
      post_request(:path => '/v1/promotioners/login', :body => params) do |async|
        response = JSON.parse(async.response)
        expect(response['token'].length).to eq(36)
        expect(response['key'].length).to eq(22)
      end
    end
  end
end
