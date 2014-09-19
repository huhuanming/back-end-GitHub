require 'spec_helper'

describe ApplicationApi do
  let(:api_options) { { :config => config_file } }
  before(:each) do
      @promotioner = FactoryGirl.create(:promotioner, :promotioner_with_login)
      @promotioner_token = @promotioner.generate_access_token
      @access_token = generate_access_token(@promotioner_token)
  end

  it '/v1/restaurants: params is invalid' do
    with_api(ApplicationApi, api_options) do |option|
    	params = Hash.new
      	params[:access_token] = @access_token
      	post_request(:path => '/v1/restaurants', :body => params) do |async|
      		response = JSON.parse(async.response)
        	expect(response['error']).to eq("Data is invalid or exist")
      	end
    end
  end

  it '/v1/restaurants: params is valid' do
    with_api(ApplicationApi, api_options) do |option|
    	params = Hash.new
      	params[:access_token] = @access_token
      	params[:restaurant_name] = "这个店很奇怪"
      	params[:supervisor_name] = "店主"
      	params[:back_account] = "7004002003004001"
      	params[:phone_number] = "27615292185"
      	params[:linsece] = "F_Y_sOs_wHg_u_dxfP_Rcq9M_OjO"
      	params[:id_card_front] = "F_Y_sOs_wHg_u_dxfP_Rcq9M_OjO"
      	params[:id_card_reverse] = "F_Y_sOs_wHg_u_dxfP_Rcq9M_OjO"
      	params[:address] = "南极洲俄罗斯舰艇9号五楼小房间隔壁右拐坐船上亚洲北京"
      	params[:radius] = "10000"
      	params[:longitude] = "103.598166"
      	params[:latitude] = "30.88798"
      	params[:coordinate_x1] = "30.88348339276481"
      	params[:coordinate_x2] = "30.89247660723519"
      	params[:coordinate_y1] = "103.60340574721802"
      	params[:coordinate_y2] = "103.592926252782"

      	post_request(:path => '/v1/restaurants', :body => params) do |async|
      		response = JSON.parse(async.response)
        	expect(response['response_status']).to eq("successed to create a restaurant")

        	restaurant = Restaurant.first
        	expect(restaurant.restaurant_name).to eq(params[:restaurant_name])
        	expect(restaurant.back_account).to eq(params[:back_account])
        	expect(restaurant.phone_number).to eq(params[:phone_number])
        	# default zone_id is zero
        	expect(restaurant.zone_id).to eq("0")

        	restaurant_linsece = RestaurantLinsece.first
        	expect(restaurant_linsece.restaurant_id).to eq(restaurant.id)
        	expect(restaurant_linsece.linsece).to eq(params[:linsece])
        	expect(restaurant_linsece.id_card_front).to eq(params[:id_card_front])
        	expect(restaurant_linsece.id_card_reverse).to eq(params[:id_card_reverse])

        	restaurant_address = RestaurantAddress.first
        	expect(restaurant_address.restaurant_id).to eq(restaurant.id)
        	expect(restaurant_address.address).to eq(params[:address])
        	expect(restaurant_address.radius).to eq(params[:radius].to_f)
        	expect(restaurant_address.longitude).to eq(params[:longitude].to_f)
        	expect(restaurant_address.latitude).to eq(params[:latitude].to_f)
        	expect(restaurant_address.coordinate_x1).to eq(params[:coordinate_x1].to_f)
        	expect(restaurant_address.coordinate_x2).to eq(params[:coordinate_x2].to_f)
        	expect(restaurant_address.coordinate_y1).to eq(params[:coordinate_y1].to_f)
        	expect(restaurant_address.coordinate_y2).to eq(params[:coordinate_y2].to_f)

        	supervisor = Supervisor.first
        	expect(supervisor.restaurant_id).to eq(restaurant.id)
        	expect(supervisor.phone_number).to eq(params[:phone_number])
        	expect(supervisor.nick_name).to eq(params[:supervisor_name])
        	expect(supervisor.password).to eq("2185")
      	end
    end
  end
end
