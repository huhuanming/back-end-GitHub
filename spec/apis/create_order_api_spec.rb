require 'spec_helper'

describe ApplicationApi do
  let(:api_options) { { :config => config_file } }
  before(:each) do
      @promotioner = FactoryGirl.create(:promotioner, :promotioner_with_login)
      @restaurant = FactoryGirl.create(:restaurant, promotioner_id: @promotioner.id)
      @restaurant_id = @restaurant.id
      @supervisor = FactoryGirl.create(:supervisor, restaurant_id: @restaurant_id)
      @food_type = FactoryGirl.create(:food_type, restaurant_id: @restaurant_id)
      @food_first = FactoryGirl.create(:food, food_type_id: @food_type.id, shop_price: 1.5)
      @food_second = FactoryGirl.create(:food, food_type_id: @food_type.id, food_name: "呵呵")
      @food_third = FactoryGirl.create(:food, food_type_id: @food_type.id, food_name: "哈哈")


      FactoryGirl.create(:food_status, food_id: @food_first.id)
      FactoryGirl.create(:food_status, food_id: @food_second.id)
      FactoryGirl.create(:food_status, food_id: @food_third.id)

      @user = FactoryGirl.create(:user)
      @user_token = @user.generate_access_token
      @access_token = generate_access_token(@user_token)
  end

  it 'POST /v1/:restaurant/orders' do
    with_api(ApplicationApi, api_options) do |option|
      path = "/v1/restaurants/" + @restaurant.id.to_s + "/orders"
      params = Hash.new
      params["access_token"] = @access_token
      params["foods"] = "[{\"fid\":\"#{@food_first.id}\",\"count\":\"2\"},{\"fid\":\"#{@food_second.id}\",\"count\":\"2\"}]"
      params["ship_type"] = 0
      params["order_type"] = 0
      params["shipping_user"] = "吃货"
      params["shipping_address"] = "我在东北玩泥巴"
      params["phone_number"] = "123456"
      post_request(:path => path, :body => params) do |async|
        response = JSON.parse(async.response)
        order_sign = OrderSign.find_by(:sign => response["order_sign"])
        order_foods = order_sign.order_foods
        expect(@food_first.food_status.sold_number).to eq(2)
        expect(@food_second.food_status.sold_number).to eq(2)
        expect(order_sign.user.id).to eq(@user.id)
        expect(order_sign.order.ship_type).to eq(0)
        expect(order_sign.order.order_type).to eq(0)
        expect(order_sign.order.shipping_user).to eq("吃货")
        expect(order_sign.order.shipping_address).to eq("我在东北玩泥巴")
        expect(order_sign.order.phone_number).to eq("123456")
        expect(order_sign.order.food_count).to eq(2)
        expect(order_sign.order.actual_total_price).to eq(@food_first.shop_price * 2 + @food_second.shop_price * 2)
        expect(order_foods.size).to eq(2)
      end
    end
  end

end