require 'spec_helper'

describe ApplicationApi do
  let(:api_options) { { :config => config_file } }
  before(:each) do
      @user = FactoryGirl.create(:user)
      @user_token = @user.generate_access_token
      @access_token = generate_access_token(@user_token)
  end
  it ':user_id/addresses: create a user address' do
    with_api(ApplicationApi, api_options) do
      params = Hash.new
      params[:access_token] = @access_token
      params[:shipping_user] = "2888"
      params[:shipping_address] = "交大"
      params[:phone_number] = "123456789"
      post_request(:path => "/v1/users/#{@user.id}/addresses", :body => params) do |async|
        response = JSON.parse(async.response)
        expect(response['response_status']).to eq("success to created")
        addresses_with_default = UserAddress.where(:user_id => @user.id)
                            .where(:is_default => 1)
        expect(addresses_with_default.size).to eq(1)
        address_with_default = addresses_with_default.first
        expect(address_with_default.user_id).to eq(@user.id)
        expect(address_with_default.shipping_user).to eq("2888")
        expect(address_with_default.shipping_address).to eq("交大")
        expect(address_with_default.phone_number).to eq("123456789")
      end
    end
  end

  it ':user_id/addresses: update a user address' do
    with_api(ApplicationApi, api_options) do
      params = Hash.new
      params[:access_token] = @access_token
      params[:shipping_user] = "2888"
      params[:shipping_address] = "交大"
      params[:phone_number] = "123456789"
      post_request(:path => "/v1/users/#{@user.id}/addresses", :body => params) do |async|
        
        params = Hash.new
        params[:access_token] = @access_token
        params[:shipping_user] = "哈哈哈"
        params[:shipping_address] = "卡布里"
        params[:phone_number] = "1111111"
        addresses_with_default = UserAddress.where(:user_id => @user.id)
                            .where(:is_default => 1)
        expect(addresses_with_default.size).to eq(1)
        address_with_default = addresses_with_default.first

        put_request(:path => "/v1/users/#{@user.id}/addresses/#{address_with_default.id}", :body => params) do |async|
          response = JSON.parse(async.response)
          expect(response['response_status']).to eq("success to updated")
          address_with_default = UserAddress.find_by_id(address_with_default.id)
          expect(address_with_default.user_id).to eq(@user.id)
          expect(address_with_default.shipping_user).to eq("哈哈哈")
          expect(address_with_default.shipping_address).to eq("卡布里")
          expect(address_with_default.phone_number).to eq("1111111")
        end
      
      end
    end
  end


  it ':user_id/addresses: get user addresses' do
    with_api(ApplicationApi, api_options) do
      params = Hash.new
      params[:access_token] = @access_token
      params[:shipping_user] = "2888"
      params[:shipping_address] = "交大"
      params[:phone_number] = "123456789"
      post_request(:path => "/v1/users/#{@user.id}/addresses", :body => params) do |async|
        

        get_request(:path => "/v1/users/#{@user.id}/addresses", :body => params) do |async|
          response = JSON.parse(async.response)
          expect(response.to_s).to eq("[{\"shipping_user\"=>\"2888\", \"shipping_address\"=>\"交大\", \"phone_number\"=>\"123456789\", \"is_default\"=>\"1\"}]")
        end

      end
    end
  end



  it ':user_id/addresses: delete a user addresses' do
    with_api(ApplicationApi, api_options) do
      params = Hash.new
      params[:access_token] = @access_token
      params[:shipping_user] = "2888"
      params[:shipping_address] = "交大"
      params[:phone_number] = "123456789"
      post_request(:path => "/v1/users/#{@user.id}/addresses", :body => params) do |async|
        
        addresses_with_default = UserAddress.where(:user_id => @user.id)
                            .where(:is_default => 1)
        expect(addresses_with_default.size).to eq(1)
        address_with_default = addresses_with_default.first

        delete_request(:path => "/v1/users/#{@user.id}/addresses/#{address_with_default.id}", :body => params) do |async|
          response = JSON.parse(async.response)
          expect(response['response_status']).to eq("success to deleted")
          expect(UserAddress.find_by_id(address_with_default.id).nil?).to eq(true)
        end

      end
    end
  end


  it ':user_id/addresses: set default user addresses' do
    with_api(ApplicationApi, api_options) do
      params = Hash.new
      params[:access_token] = @access_token
      params[:shipping_user] = "2888"
      params[:shipping_address] = "交大"
      params[:phone_number] = "123456789"
      post_request(:path => "/v1/users/#{@user.id}/addresses", :body => params) do |async|
        
        addresses_with_default = UserAddress.where(:user_id => @user.id)
                            .where(:is_default => 1)
        expect(addresses_with_default.size).to eq(1)
        address_with_default = addresses_with_default.first

        put_request(:path => "/v1/users/#{@user.id}/addresses/#{address_with_default.id}/is_default", :body => params) do |async|
          response = JSON.parse(async.response)
          expect(response['response_status']).to eq("this address was default")
        end

      end
    end
  end

  it ':user_id/addresses: set default user addresses' do
    with_api(ApplicationApi, api_options) do
      params = Hash.new
      params[:access_token] = @access_token
      params[:shipping_user] = "2888"
      params[:shipping_address] = "交大"
      params[:phone_number] = "123456789"
      post_request(:path => "/v1/users/#{@user.id}/addresses", :body => params) do |async|
        
        addresses_with_default = UserAddress.where(:user_id => @user.id)
                            .where(:is_default => 1)
        expect(addresses_with_default.size).to eq(1)
        address_with_default = addresses_with_default.first

        put_request(:path => "/v1/users/#{@user.id}/addresses/#{address_with_default.id}/is_default", :body => params) do |async|
          response = JSON.parse(async.response)
          expect(response['response_status']).to eq("this address was default")
        end

      end
    end
  end

  it ':user_id/addresses/default_address: get a default user addresses' do
    with_api(ApplicationApi, api_options) do
      params = Hash.new
      params[:access_token] = @access_token
      params[:shipping_user] = "2888"
      params[:shipping_address] = "交大"
      params[:phone_number] = "123456789"
      post_request(:path => "/v1/users/#{@user.id}/addresses", :body => params) do |async|
        
        addresses_with_default = UserAddress.where(:user_id => @user.id)
                            .where(:is_default => 1)
        expect(addresses_with_default.size).to eq(1)
        address_with_default = addresses_with_default.first

        get_request(:path => "/v1/users/#{@user.id}/addresses/default_address", :body => params) do |async|
          response = JSON.parse(async.response)
          expect(response["shipping_user"]).to eq("2888")
          expect(response["shipping_address"]).to eq("交大")
          expect(response["phone_number"]).to eq("123456789")
          expect(response["is_default"]).to eq("1")
        end

      end
    end
  end

end
