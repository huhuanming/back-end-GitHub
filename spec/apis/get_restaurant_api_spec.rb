require 'spec_helper'

describe ApplicationApi do
  let(:api_options) { { :config => config_file } }
  before(:each) do
      @promotioner = FactoryGirl.create(:promotioner, :promotioner_with_login)
      @current_time = Time.now
      @locations = { 
                    0 => [12, 12, 10, 14, 10, 14, 28, 27],
                    1 => [8, 19, 6, 10, 17, 21, 6, 20],
                    2 => [9, 12, 7, 11, 10, 14, 22, 8],
                    3 => [16, 5, 14, 18, 3, 7, 20, 15],
                    4 => [16, 8, 14, 18, 6, 10, 14, 21],
                    5 => [16, 17, 14, 18, 15, 19, 27, 6],
                    6 => [16, 16, 14, 18, 14, 18, 12, 26],
                    7 => [14, 4, 12, 16, 2, 6, 25, 11],
                    8 => [13, 19, 11, 14, 17, 21, 5, 20],
                    9 => [6, 14, 4, 8, 12, 16, 19, 8],
                    10 => [14, 5, 12, 16, 3, 7, 25, 5],
                    11 => [17, 19, 15, 19, 17, 21, 22, 8],
                  }
        @locations.each_with_index{ |location, index| 
	      @restaurant = FactoryGirl.create(:restaurant, promotioner_id: @promotioner.id, restaurant_name:"餐馆#{index}")
	      @restaurant_id = @restaurant.id
        this_time = @current_time
        this_time = @current_time - 1.day if index.odd?
	      FactoryGirl.create(:restaurant_status, restaurant_id: @restaurant_id, shipping_phone_number: @restaurant.phone_number, checked_at: this_time, shipping_time:location[1][6], shipping_fee:location[1][7])
	      FactoryGirl.create(:restaurant_address, restaurant_id: @restaurant_id, longitude: location[1][0], latitude:location[1][1], coordinate_x1:location[1][2], coordinate_x2:location[1][3], coordinate_y1:location[1][4], coordinate_y2:location[1][5])
      }
  end

  it 'GET /v1/restaurants: your location is not near by all restaurants  and  no order_type and no restaurant_type' do
    with_api(ApplicationApi, api_options) do |option|
      params = Hash.new
        params[:longitude] = 10
        params[:latitude] = 28
        get_request(:path => '/v1/restaurants', :body => params) do |async|
          response = JSON.parse(async.response)
          expect(response.size).to eq(0)

          params[:longitude] = 4
          params[:latitude] = 12
          get_request(:path => '/v1/restaurants', :body => params) do |async|
            response = JSON.parse(async.response)
            expect(response.size).to eq(0)

            params[:longitude] = -100
            params[:latitude] = -10
            get_request(:path => '/v1/restaurants', :body => params) do |async|
              response = JSON.parse(async.response)
              expect(response.size).to eq(0)
            end

          end

        end
    end
  end

  it 'GET /v1/restaurants: your location is near by all restaurants  and  no order_type and no restaurant_type' do
    with_api(ApplicationApi, api_options) do |option|
    	params = Hash.new
      	params[:longitude] = 15
      	params[:latitude] = 17
      	get_request(:path => '/v1/restaurants', :body => params) do |async|
      		response = JSON.parse(async.response)
          expect(response.size).to eq(1)
          response.each{ |the_res|
            db_res = Restaurant.find_by(:id => the_res["rid"])
            expect(the_res["name"]).to eq(db_res["restaurant_name"])
            expect(the_res["avatar"]).to eq(db_res["restaurant_avatar"])

            db_res_status = db_res.restaurant_status
            the_res_status = the_res["status"]

            expect(the_res_status["start_shipping_fee"].to_f).to eq(db_res_status["start_shipping_fee"])
            expect(the_res_status["shipping_time"]).to eq(db_res_status["shipping_time"])
          }
      	end
    end
  end



  it 'GET /v1/restaurants: order by shipping_time' do
      @current_time = Time.now
      @locations = { 
                    0 => [100, 100, 98, 104, 98, 104, 28, 27],
                    1 => [100, 100, 98, 104, 98, 104, 6, 20],
                    2 => [100, 100, 98, 104, 98, 104, 22, 8],
                    3 => [100, 100, 98, 104, 98, 104, 20, 15],
                    4 => [100, 100, 98, 104, 98, 104, 14, 21],
                    5 => [100, 100, 98, 104, 98, 104, 27, 6],
                    6 => [100, 100, 98, 104, 98, 104, 12, 26],
                    7 => [100, 100, 98, 104, 98, 104, 11, 22],
                    8 => [100, 100, 98, 104, 98, 104, 5, 20],
                    9 => [100, 100, 98, 104, 98, 104, 19, 8],
                    10 => [100, 100, 98, 104, 98, 104, 25, 5],
                    11 => [100, 100, 98, 104, 98, 104, 22, 8],
                  }
    @locations.each_with_index{ |location, index| 
      @restaurant = FactoryGirl.create(:restaurant, promotioner_id: @promotioner.id, restaurant_name:"餐馆#{index}")
      @restaurant_id = @restaurant.id
      this_time = @current_time
      FactoryGirl.create(:restaurant_status, restaurant_id: @restaurant_id, shipping_phone_number: @restaurant.phone_number, checked_at: this_time, shipping_time:location[1][6], shipping_fee:location[1][7])
      FactoryGirl.create(:restaurant_address, restaurant_id: @restaurant_id, longitude: location[1][0], latitude:location[1][1], coordinate_x1:location[1][2], coordinate_x2:location[1][3], coordinate_y1:location[1][4], coordinate_y2:location[1][5])
    }
    with_api(ApplicationApi, api_options) do |option|
        params = Hash.new
        params[:longitude] = 101
        params[:latitude] = 102
        params[:order_type] = 1
        get_request(:path => '/v1/restaurants', :body => params) do |async|
            response = JSON.parse(async.response)
            expect(response[0]["status"]["shipping_time"]).to eq(@locations[8][6])
            expect(response[6]["status"]["shipping_time"]).to eq(@locations[3][6])
            expect(response[11]["status"]["shipping_time"]).to eq(@locations[0][6])
        end
    end
  end

  it 'GET /v1/restaurants: order by distanche' do
      @current_time = Time.now
      @locations = { 
                    0 => [97, 92, 90, 104, 90, 104, 28, 27],
                    1 => [90, 92, 90, 104, 90, 104, 6, 20],
                    2 => [98, 98, 90, 104, 90, 104, 22, 8],
                    3 => [93, 100, 90, 104, 90, 104, 20, 15],
                    4 => [98, 93, 90, 104, 90, 104, 14, 21],
                    5 => [92, 94, 90, 104, 90, 104, 27, 6],
                    6 => [95, 95, 90, 104, 90, 104, 12, 26],
                    7 => [94, 96, 90, 104, 90, 104, 11, 22],
                    8 => [93, 94, 90, 104, 90, 104, 5, 20],
                    9 => [98, 96, 90, 104, 90, 104, 19, 8],
                    10 => [92, 97, 90, 104, 90, 104, 25, 5],
                    11 => [95, 97, 90, 104, 90, 104, 22, 8],
                  }
    @locations.each_with_index{ |location, index| 
      @restaurant = FactoryGirl.create(:restaurant, promotioner_id: @promotioner.id, restaurant_name:"餐馆#{index}")
      @restaurant_id = @restaurant.id
      this_time = @current_time
      FactoryGirl.create(:restaurant_status, restaurant_id: @restaurant_id, shipping_phone_number: @restaurant.phone_number, checked_at: this_time, shipping_time:location[1][6], shipping_fee:location[1][7])
      FactoryGirl.create(:restaurant_address, restaurant_id: @restaurant_id, longitude: location[1][0], latitude:location[1][1], coordinate_x1:location[1][2], coordinate_x2:location[1][3], coordinate_y1:location[1][4], coordinate_y2:location[1][5])
    }
    with_api(ApplicationApi, api_options) do |option|
        params = Hash.new
        params[:longitude] = 95
        params[:latitude] = 95
        params[:order_type] = 2
        get_request(:path => '/v1/restaurants', :body => params) do |async|
            response = JSON.parse(async.response)
            expect(response[0]["rid"]).to eq(13 + 6)
            expect(response[6]["rid"]).to eq(13 + 0)
            expect(response[11]["rid"]).to eq(13 + 1)
        end
    end
  end



  it 'GET /v1/restaurants: order by distanche' do
      @current_time = Time.now
      @locations = { 
                    0 => [97, 92, 90, 104, 90, 104, 28, 27],
                    1 => [90, 92, 90, 104, 90, 104, 6, 20],
                    2 => [98, 98, 90, 104, 90, 104, 22, 8],
                    3 => [93, 100, 90, 104, 90, 104, 20, 15],
                    4 => [98, 93, 90, 104, 90, 104, 14, 21],
                    5 => [92, 94, 90, 104, 90, 104, 27, 6],
                    6 => [95, 95, 90, 104, 90, 104, 12, 26],
                    7 => [94, 96, 90, 104, 90, 104, 11, 22],
                    8 => [93, 94, 90, 104, 90, 104, 5, 20],
                    9 => [98, 96, 90, 104, 90, 104, 19, 8],
                    10 => [92, 97, 90, 104, 90, 104, 25, 5],
                    11 => [95, 97, 90, 104, 90, 104, 22, 8],
                  }
    @locations.each_with_index{ |location, index| 
      @restaurant = FactoryGirl.create(:restaurant, promotioner_id: @promotioner.id, restaurant_name:"餐馆#{index}")
      @restaurant_id = @restaurant.id
      this_time = @current_time
      FactoryGirl.create(:restaurant_status, restaurant_id: @restaurant_id, shipping_phone_number: @restaurant.phone_number, checked_at: this_time, shipping_time:location[1][6], shipping_fee:location[1][7])
      FactoryGirl.create(:restaurant_address, restaurant_id: @restaurant_id, longitude: location[1][0], latitude:location[1][1], coordinate_x1:location[1][2], coordinate_x2:location[1][3], coordinate_y1:location[1][4], coordinate_y2:location[1][5])
    }
    with_api(ApplicationApi, api_options) do |option|
        params = Hash.new
        params[:longitude] = 95
        params[:latitude] = 95
        params[:order_type] = 3
        get_request(:path => '/v1/restaurants', :body => params) do |async|
            response = JSON.parse(async.response)
            expect(response[0]["rid"]).to eq(13 + 10)
            expect(response[5]["rid"]).to eq(13 + 3)
            expect(response[11]["rid"]).to eq(13 + 0)
        end
    end
  end

end