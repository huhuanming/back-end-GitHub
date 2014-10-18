# require 'spec_helper'

# describe ApplicationApi do
#   let(:api_options) { { :config => config_file } }
#   before(:each) do
#       @current_time = Time.now
#       @locations = { 
#                     0 => [100, 100, 98, 104, 98, 104, 28, 27],
#                     1 => [100, 100, 98, 104, 98, 104, 6, 20],
#                     2 => [100, 100, 98, 104, 98, 104, 22, 8],
#                     3 => [100, 100, 98, 104, 98, 104, 20, 15],
#                     4 => [100, 100, 98, 104, 98, 104, 14, 21],
#                     5 => [100, 100, 98, 104, 98, 104, 27, 6],
#                     6 => [100, 100, 98, 104, 98, 104, 12, 26],
#                     7 => [100, 100, 98, 104, 98, 104, 11, 22],
#                     8 => [100, 100, 98, 104, 98, 104, 5, 20],
#                     9 => [100, 100, 98, 104, 98, 104, 19, 8],
#                     10 => [100, 100, 98, 104, 98, 104, 25, 5],
#                     11 => [100, 100, 98, 104, 98, 104, 22, 8],
#                   }
#       @locations.each_with_index{ |location, index| 
#       @restaurant = FactoryGirl.create(:restaurant, promotioner_id: @promotioner.id, restaurant_name:"餐馆#{index}")
#       @restaurant_id = @restaurant.id
#       this_time = @current_time
#       FactoryGirl.create(:restaurant_status, restaurant_id: @restaurant_id, shipping_phone_number: @restaurant.phone_number, checked_at: this_time, shipping_time:location[1][6], shipping_fee:location[1][7])
#       FactoryGirl.create(:restaurant_address, restaurant_id: @restaurant_id, longitude: location[1][0], latitude:location[1][1], coordinate_x1:location[1][2], coordinate_x2:location[1][3], coordinate_y1:location[1][4], coordinate_y2:location[1][5])
#     }
#   end

#   it '/v1/search_food' do
#     with_api(ApplicationApi, api_options) do |option|
#     	params = Hash.new
#       	params[:longitude] = @access_token
#       	params[:latitude] = @access_token
#       	params[:food_name] = @access_token
#       	post_request(:path => '/v1/restaurants/search_food', :body => params) do |async|
#       		response = JSON.parse(async.response)
#         	expect(response['error']).to eq("Data is invalid or exist")
#       	end
#     end
#   end

#  end