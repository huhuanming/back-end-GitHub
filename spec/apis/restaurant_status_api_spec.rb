require 'spec_helper'

describe ApplicationApi do
  let(:api_options) { { :config => config_file } }
  before(:each) do
      @promotioner = FactoryGirl.create(:promotioner, :promotioner_with_login)
      @restaurant = FactoryGirl.create(:restaurant, promotioner_id: @promotioner.id)
      @restaurant_id = @restaurant.id
      @this_time = Time.now - 1.day
      @restaurant_status = FactoryGirl.create(:restaurant_status, restaurant_id: @restaurant_id, shipping_phone_number: @restaurant.phone_number, checked_at: @this_time)
      @supervisor = FactoryGirl.create(:supervisor, restaurant_id: @restaurant_id)
      @supervisor_token = @supervisor.generate_access_token
      @access_token = generate_access_token(@supervisor_token)
  end

  it 'Check restaurant_status is exist' do
    with_api(ApplicationApi, api_options) do |option|
        path = "/v1/restaurants/" + @restaurant_id.to_s + "/setting"
    	  params = Hash.new
      	params[:access_token] = @access_token
      	get_request(:path => path, :body => params) do |async|
      		response = JSON.parse(async.response)
          expect(response["board"]).to eq("欢迎光临")
          expect(response["close_hour"]).to eq(23)
          expect(response["close_min"]).to eq(59)
          expect(response["start_shipping_fee"].to_f).to eq(10.0)
          expect(response["shipping_fee"].to_f).to eq(0.0)
          expect(response["shipping_time"]).to eq(20)
          expect(response["shipping_phone_number"]).to eq(@restaurant.phone_number)
          expect(response["is_sms"]).to eq(0)
          expect(response["is_client"]).to eq(1)
          expect(response["checked_at"].nil?).to eq(false)
      	end
    end
  end

end
