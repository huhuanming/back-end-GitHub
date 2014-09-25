require 'spec_helper'

describe ApplicationApi do
  let(:api_options) { { :config => config_file } }
  before(:each) do
      # @promotioner = FactoryGirl.create(:promotioner)
      # @restaurant = FactoryGirl.create(:restaurant, promotioner_id: @promotioner.id)
      # @supervisor = FactoryGirl.create(:supervisor, restaurant_id: @restaurant.id)
  end
  it '/v1/users/mobile_verification_code' do
    with_api(ApplicationApi, api_options) do
      params = Hash.new
      params[:phone_number] = "18628271096"
      get_request(:path => '/v1/users/mobile_verification_code', :body => params) do |async|
        response = JSON.parse(async.response)
        expect(response['response_status']).to eq("success to get it and please note that check your mobile phone")
      end
    end
  end

end
