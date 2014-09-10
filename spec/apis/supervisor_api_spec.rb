require 'spec_helper'

describe ApplicationApi do
  let(:api_options) { { :config => config_file } }
  before(:each) do
      @promotioner = FactoryGirl.create(:promotioner)
      @restaurant = FactoryGirl.create(:restaurant, promotioner_id: @promotioner.id)
      @supervisor = FactoryGirl.create(:supervisor, restaurant_id: @restaurant.id)
  end
  it '/v1/supervisors/login: Username or password is invalid' do
    with_api(ApplicationApi, api_options) do
      params = Hash.new
      params[:username] = "91234999000"
      params[:password] = "2888"
      post_request(:path => '/v1/supervisors/login', :body => params) do |async|
        response = JSON.parse(async.response)
        expect(response['error']).to eq("Username or password is invalid")
      end
    end
  end

  it '/v1/supervisors/login: Username or password is valid' do
    with_api(ApplicationApi, api_options) do
      params = Hash.new
      params[:username] = "1212"
      params[:password] = "1212"
      post_request(:path => '/v1/supervisors/login', :body => params) do |async|
        response = JSON.parse(async.response)
        expect(response['last_login_at'].length).to eq(20)
        expect(response['login_count']).to eq(1)
        access_token = response["access_token"]
        expect(access_token['token'].length).to eq(36)
        expect(access_token['key'].length).to eq(22)
      end
    end
  end
end
