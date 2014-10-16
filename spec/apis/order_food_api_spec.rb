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
      @food_type = FactoryGirl.create(:food_type, restaurant_id: @restaurant_id)
      @food_first = FactoryGirl.create(:food, food_type_id: @food_type.id, shop_price: 1.5)
      @food_second = FactoryGirl.create(:food, food_type_id: @food_type.id, food_name: "呵呵")       
      @order = FactoryGirl.create(:order, phone_number: "12313", restaurant_id: @restaurant_id, shipping_at: Time.new + 30.minutes)
      FactoryGirl.create(:order_food, order_id: @order.id, food_id: @food_first.id)
      FactoryGirl.create(:order_food, order_id: @order.id, food_id: @food_second.id)
  end

  it 'GET :restaurant_id/orders/:order_id' do
    with_api(ApplicationApi, api_options) do |option|
      path = "/v1/restaurants/" + @restaurant.id.to_s + "/orders/" + @order.id.to_s
      params = Hash.new
      params["access_token"] = @access_token
      get_request(:path => path, :body => params) do |async|
        response = JSON.parse(async.response)
        expect(response.size).to eq(2)
        expect(response.to_s).to eq("[{\"count\"=>1, \"total_price\"=>\"12.4\", \"actual_total_price\"=>\"12.4\", \"food\"=>{\"food_name\"=>\"翔啊\", \"shop_price\"=>\"1.5\"}}, {\"count\"=>1, \"total_price\"=>\"12.4\", \"actual_total_price\"=>\"12.4\", \"food\"=>{\"food_name\"=>\"呵呵\", \"shop_price\"=>\"998.0\"}}]")
      end
    end
  end

end
