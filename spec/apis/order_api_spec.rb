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
      6.times.each{ |index|
        FactoryGirl.create(:order, phone_number: index, restaurant_id: @restaurant_id, shipping_at: Time.new + 30.minutes)
      }
  end

  it 'GET /v1/:restaurant/orders' do
    with_api(ApplicationApi, api_options) do |option|
      path = "/v1/restaurants/" + @restaurant.id.to_s + "/orders"
      params = Hash.new
      params["access_token"] = @access_token
      get_request(:path => path, :body => params) do |async|
        response = JSON.parse(async.response)
        expect(response.size).to eq(6)
        response.each_with_index{ |order,index|
            the_order = Order.find_by_id(order["order_id"])
            expect(order["ship_type"]).to eq(the_order.ship_type)
            expect(order["order_type"]).to eq(the_order.order_type)
            expect(order["phone_number"]).to eq(the_order.phone_number)
            expect(order["shipping_address"]).to eq(the_order.shipping_address)
            expect(order["shipping_user"]).to eq(the_order.shipping_user)
            expect(order["total_price"]).to eq(the_order.total_price.to_s)
            expect(order["food_count"].to_i).to eq(2)
            expect(order["actual_total_price"]).to eq(the_order.actual_total_price.to_s)
            expect(order["order_remark"]).to eq("无")
            expect(order["created_at"]).to eq(the_order.created_at.iso8601)
            expect(order["updated_at"]).to eq(the_order.updated_at.iso8601)
            expect(order["shipping_at"]).to eq(the_order.shipping_at.iso8601)
        }
      end
    end
  end

  it 'GET page /v1/:restaurant/orders' do
    with_api(ApplicationApi, api_options) do |option|
      path = "/v1/restaurants/" + @restaurant.id.to_s + "/orders"
      params = Hash.new
      params["access_token"] = @access_token
      params["id"] = 5
      get_request(:path => path, :body => params) do |async|
        response = JSON.parse(async.response)        
        expect(response.size).to eq(4)
        params["id"] = 3
        get_request(:path => path, :body => params) do |async|
          response = JSON.parse(async.response)  
          expect(response.size).to eq(2)
        end
      end
    end
  end

  it 'GET per_page /v1/:restaurant/orders' do
    with_api(ApplicationApi, api_options) do |option|
      path = "/v1/restaurants/" + @restaurant.id.to_s + "/orders"
      params = Hash.new
      params["access_token"] = @access_token
      params["id"] = 2
      params["count"] = 2
      get_request(:path => path, :body => params) do |async|
        response = JSON.parse(async.response)
        expect(response.size).to eq(1)
      end
    end
  end

  it 'PUT :restaurant_id/orders/:order_id/check_order' do
    with_api(ApplicationApi, api_options) do |option|
      order_id = Order.first.id.to_s
      path = "/v1/restaurants/" + @restaurant.id.to_s + "/orders/"+ order_id + "/check_order"
      params = Hash.new
      params["access_token"] = @access_token
      put_request(:path => path, :body => params) do |async|
        response = JSON.parse(async.response)
        expect(response.to_s).to eq("{\"response_status\"=>\"This order was checked\"}")
        expect(Order.find_by_id(order_id).order_type).to eq(1)
        expect(Order.find_by_id(3).order_type).to eq(0)
      end
    end
  end

  it 'PUT restaurant_id is not belongs to this supervisor:restaurant_id/orders/:order_id/check_order' do
    with_api(ApplicationApi, api_options) do |option|
      path = "/v1/restaurants/" + "100" + "/orders/"+"1"+"/check_order"
      params = Hash.new
      params["access_token"] = @access_token
      put_request(:path => path, :body => params) do |async|
        response = JSON.parse(async.response)
        expect(response.to_s).to eq("{\"error\"=>\"supervisor is invaild\"}")
      end
    end
  end

  it 'PUT order_id is not belongs to this restaurant_id:restaurant_id/orders/:order_id/check_order' do
    with_api(ApplicationApi, api_options) do |option|
      path = "/v1/restaurants/" + @restaurant.id.to_s + "/orders/"+"100"+"/check_order"
      params = Hash.new
      params["access_token"] = @access_token
      put_request(:path => path, :body => params) do |async|
        response = JSON.parse(async.response)
        expect(response.to_s).to eq("{\"error\"=>\"not found\"}")
      end
    end
  end

end
