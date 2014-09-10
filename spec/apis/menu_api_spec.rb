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

  it '/v1/menus: menu_json is invalid, json is invalid' do
    with_api(ApplicationApi, api_options) do |option|
      params = Hash.new
      params[:access_token] = @access_token

      params[:menu_json] = "{\"菜品一\"{\"青菜\":{\"price\":\"3.0\"},\"白菜\":{\"price\":\"2.0\"}},\"菜品二\":{\"紫菜\":{\"price\":\"2.5\"},\"花菜\":{\"price\":\"10.5\"}}}"
      post_request(:path => '/v1/menus', :body => params) do |async|
        response = JSON.parse(async.response)
        expect(response['error']).to eq("menu_json is invalid")
      end

    end
  end

  it '/v1/menus: menu_json is invalid, json is invalid, no keys' do
    with_api(ApplicationApi, api_options) do |option|
      params = Hash.new
      params[:access_token] = @access_token
      params[:menu_json] = "{\"菜\":[\"菜品一\",\"菜品二\"]}"
      post_request(:path => '/v1/menus', :body => params) do |async|
        response = JSON.parse(async.response)
        expect(response['error']).to eq("menu_json is invalid")
      end

    end
  end

  it '/v1/menus: menu_json is invalid, json is invalid, no price' do
    with_api(ApplicationApi, api_options) do |option|
      params = Hash.new
      params[:access_token] = @access_token
      params[:menu_json] = "{\"菜品一\":{\"青菜\":{\"a\":\"3.0\"},\"白菜\":{\"b\":\"2.0\"}},\"菜品二\":{\"紫菜\":{\"c\":\"2.5\"},\"花菜\":{\"d\":\"10.5\"}}}"
      post_request(:path => '/v1/menus', :body => params) do |async|
        response = JSON.parse(async.response)
        expect(response['error']).to eq("menu_json is invalid")
      end

    end
  end

  it '/v1/menus: menu_json is valid' do
    with_api(ApplicationApi, api_options) do |option|
      params = Hash.new
      params[:access_token] = @access_token
      params[:menu_json] = "{\"菜品一\":{\"青菜\":{\"price\":\"3.0\"},\"白菜\":{\"price\":\"2.0\"}},\"菜品二\":{\"紫菜\":{\"price\":\"2.5\"},\"花菜\":{\"price\":\"10.5\"}}}"
      post_request(:path => '/v1/menus', :body => params) do |async|
        response = JSON.parse(async.response)
        expect(response['response_status']).to eq("successed to update menu of this restaurant")

        menu = JSON.parse(params[:menu_json])
        types = menu.keys
        the_types = FoodType.all.pluck(:type_name)
        expect(the_types).to eq(types)

        types.each do |type_name|
          foods = menu[type_name]
          foods.keys.each do |key|
           the_food = Food.find_by(:food_name => key)
           food = foods[key]
           expect(the_food.shop_price).to eq(food["price"].to_f)
          end 
        end
      end
    end
  end

  it '/v1/menus: menu_json is valid and database has types and foods before food' do
    @food_type = FactoryGirl.create(:food_type, restaurant_id: @restaurant_id)
    expect(FoodType.find_by(:type_name => "翔类").nil?).to eq(false)

    @food = FactoryGirl.create(:food, food_type_id: @food_type.id)
    expect(Food.find_by(:food_name => "翔啊").nil?).to eq(false)

    with_api(ApplicationApi, api_options) do |option|
      params = Hash.new
      params[:access_token] = @access_token
      params[:menu_json] = "{\"菜品一\":{\"青菜\":{\"price\":\"3.0\"},\"白菜\":{\"price\":\"2.0\"}},\"菜品二\":{\"紫菜\":{\"price\":\"2.5\"},\"花菜\":{\"price\":\"10.5\"}}}"
      post_request(:path => '/v1/menus', :body => params) do |async|
        response = JSON.parse(async.response)
        expect(response['response_status']).to eq("successed to update menu of this restaurant")

        expect(FoodType.find_by(:type_name => "翔类").nil?).to eq(true)
         expect(Food.find_by(:food_name => "翔啊").nil?).to eq(true)

        menu = JSON.parse(params[:menu_json])
        types = menu.keys
        the_types = FoodType.all.pluck(:type_name)
        expect(the_types).to eq(types)

        types.each do |type_name|
          foods = menu[type_name]
          foods.keys.each do |key|
           the_food = Food.find_by(:food_name => key)
           food = foods[key]
           expect(the_food.shop_price).to eq(food["price"].to_f)
          end 
        end
      end
    end
  end

  it '/v1/menus: exsit before' do
    @food_type = FactoryGirl.create(:food_type, restaurant_id: @restaurant_id)
    expect(FoodType.find_by(:type_name => "翔类").nil?).to eq(false)

    @food = FactoryGirl.create(:food, food_type_id: @food_type.id)
    expect(Food.find_by(:food_name => "翔啊").nil?).to eq(false)

    with_api(ApplicationApi, api_options) do |option|
      params = Hash.new
      params[:access_token] = @access_token
      params[:menu_json] = "{\"翔类\":{\"翔啊\":{\"price\":\"3.0\"},\"白菜\":{\"price\":\"2.0\"}},\"菜品二\":{\"紫菜\":{\"price\":\"2.5\"},\"花菜\":{\"price\":\"10.5\"}}}"
      post_request(:path => '/v1/menus', :body => params) do |async|
        response = JSON.parse(async.response)
        expect(response['response_status']).to eq("successed to update menu of this restaurant")

        expect(FoodType.find_by(:type_name => "翔类").nil?).to eq(false)
        expect(Food.find_by(:food_name => "翔啊").nil?).to eq(false)

        menu = JSON.parse(params[:menu_json])
        types = menu.keys
        the_types = FoodType.all.pluck(:type_name)
        expect(the_types).to eq(types)

        types.each do |type_name|
          foods = menu[type_name]
          foods.keys.each do |key|
           the_food = Food.find_by(:food_name => key)
           food = foods[key]
           expect(the_food.shop_price).to eq(food["price"].to_f)
          end 
        end
      end
    end
  end

   it '/v1/menus: exsit before' do
    @food_type = FactoryGirl.create(:food_type, restaurant_id: @restaurant_id)
    expect(FoodType.find_by(:type_name => "翔类").nil?).to eq(false)

    @food = FactoryGirl.create(:food, food_type_id: @food_type.id)
    expect(Food.find_by(:food_name => "翔啊").nil?).to eq(false)

    with_api(ApplicationApi, api_options) do |option|
      params = Hash.new
      params[:access_token] = @access_token
      params[:menu_json] = "{\"翔类\":{\"大白菜\":{\"price\":\"3.0\"},\"白菜\":{\"price\":\"2.0\"}},\"菜品二\":{\"翔啊\":{\"price\":\"2.5\"},\"花菜\":{\"price\":\"10.5\"}}}"
      post_request(:path => '/v1/menus', :body => params) do |async|
        response = JSON.parse(async.response)
        expect(response['response_status']).to eq("successed to update menu of this restaurant")
        expect(FoodType.find_by(:type_name => "翔类").nil?).to eq(false)
        expect(Food.find_by(:food_name => "翔啊").nil?).to eq(false)

        menu = JSON.parse(params[:menu_json])
        types = menu.keys
        the_types = FoodType.all.pluck(:type_name)
        expect(the_types).to eq(types)

        types.each do |type_name|
          foods = menu[type_name]
          foods.keys.each do |key|
           the_food = Food.find_by(:food_name => key)
           food = foods[key]
           expect(the_food.shop_price).to eq(food["price"].to_f)
          end 
        end
      end
    end
  end

   it '/v1/menus: exsit before' do
    @food_type = FactoryGirl.create(:food_type, restaurant_id: @restaurant_id)
    expect(FoodType.find_by(:type_name => "翔类").nil?).to eq(false)

    @food = FactoryGirl.create(:food, food_type_id: @food_type.id)
    expect(Food.find_by(:food_name => "翔啊").nil?).to eq(false)

    with_api(ApplicationApi, api_options) do |option|
      params = Hash.new
      params[:access_token] = @access_token
      params[:menu_json] = "{\"菜品二\":{\"大白菜\":{\"price\":\"3.0\"},\"白菜\":{\"price\":\"2.0\"}},\"翔类\":{\"翔啊\":{\"price\":\"2.5\"},\"花菜\":{\"price\":\"10.5\"}}}"
      post_request(:path => '/v1/menus', :body => params) do |async|
        response = JSON.parse(async.response)
        expect(response['response_status']).to eq("successed to update menu of this restaurant")
        expect(FoodType.find_by(:type_name => "翔类").nil?).to eq(false)
        expect(Food.find_by(:food_name => "翔啊").nil?).to eq(false)

        menu = JSON.parse(params[:menu_json])
        types = menu.keys
        the_types = FoodType.all.pluck(:type_name)
        expect(the_types.sort!).to eq(types.sort!)

        types.each do |type_name|
          foods = menu[type_name]
          foods.keys.each do |key|
           the_food = Food.find_by(:food_name => key)
           food = foods[key]
           expect(the_food.shop_price).to eq(food["price"].to_f)
          end 
        end
      end
    end
  end

  it '/v1/menus: exsit before' do
    @food_type = FactoryGirl.create(:food_type, restaurant_id: @restaurant_id)
    expect(FoodType.find_by(:type_name => "翔类").nil?).to eq(false)

    @food = FactoryGirl.create(:food, food_type_id: @food_type.id)
    expect(Food.find_by(:food_name => "翔啊").nil?).to eq(false)

    with_api(ApplicationApi, api_options) do |option|
      params = Hash.new
      params[:access_token] = @access_token
      params[:menu_json] = "{\"菜品二\":{\"翔啊\":{\"price\":\"3.0\"},\"白菜\":{\"price\":\"2.0\"}},\"翔类\":{\"好菜\":{\"price\":\"2.5\"},\"花菜\":{\"price\":\"10.5\"}}}"
      post_request(:path => '/v1/menus', :body => params) do |async|
        response = JSON.parse(async.response)
        expect(response['response_status']).to eq("successed to update menu of this restaurant")
        expect(FoodType.find_by(:type_name => "翔类").nil?).to eq(false)
        expect(Food.find_by(:food_name => "翔啊").nil?).to eq(false)

        menu = JSON.parse(params[:menu_json])
        types = menu.keys
        the_types = FoodType.all.pluck(:type_name)
        expect(the_types.sort!).to eq(types.sort!)

        types.each do |type_name|
          foods = menu[type_name]
          foods.keys.each do |key|
           the_food = Food.find_by(:food_name => key)
           food = foods[key]
           expect(the_food.shop_price).to eq(food["price"].to_f)
          end 
        end
      end
    end
  end

end
