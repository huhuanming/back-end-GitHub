require 'spec_helper'

describe ApplicationApi do
  let(:api_options) { { :config => config_file } }
  before(:each) do
      @promotioner = FactoryGirl.create(:promotioner, :promotioner_with_login)
      @restaurant = FactoryGirl.create(:restaurant, promotioner_id: @promotioner.id)
      @restaurant_id = @restaurant.id
      @supervisor = FactoryGirl.create(:supervisor, restaurant_id: @restaurant_id)
      @supervisor_token = @supervisor.generate_access_token
      @access_token = generate_access_token(@supervisor_token)
  end
  it 'GET /v1/orders:' do
    with_api(ApplicationApi, api_options) do |option|
      path = '/v1/orders'
      params = Hash.new
      params["access_token"] = @access_token
      get_request(:path => path, :body => params) do |async|
        response = JSON.parse(async.response)
        pp response
        # expect(resp['api_version']).to eq("v1")
      end
    end
  end
end
