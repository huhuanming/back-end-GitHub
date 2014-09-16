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
            the_order = Order.find_by_id(index+1)
            expect(order["ship_type"]).to eq(the_order.ship_type)
            expect(order["order_type"]).to eq(the_order.order_type)
            expect(order["phone_number"]).to eq(the_order.phone_number)
            expect(order["shipping_address"]).to eq(the_order.shipping_address)
            expect(order["total_price"]).to eq(the_order.total_price.to_s)
            expect(order["actual_total_price"]).to eq(the_order.actual_total_price.to_s)
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
      params["page"] = 2
      get_request(:path => path, :body => params) do |async|
        response = JSON.parse(async.response)
        expect(response.size).to eq(0)

        params["page"] = 1
        get_request(:path => path, :body => params) do |async|
          response = JSON.parse(async.response)
          expect(response.size).to eq(6)
        end
      end
    end
  end



  it 'GET per_page /v1/:restaurant/orders' do
    with_api(ApplicationApi, api_options) do |option|
      path = "/v1/restaurants/" + @restaurant.id.to_s + "/orders"
      params = Hash.new
      params["access_token"] = @access_token
      params["page"] = 1
      params["per_page"] = 2
      get_request(:path => path, :body => params) do |async|
        response = JSON.parse(async.response)
        expect(response.size).to eq(2)
      end
    end
  end

end
