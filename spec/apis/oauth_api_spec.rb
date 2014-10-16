require 'spec_helper'

describe ApplicationApi do
  let(:api_options) { { :config => config_file } }
  before(:each) do

  end

  it 'login by oauth with wrong access token: /v1/users/login_by_oauth' do
    with_api(ApplicationApi, api_options) do
      params = Hash.new
      params[:uid] = "12345678910"
      params[:oauth_type] = 0
      params[:oauth_token] = "12354y6gweft45ey6ur754t356"
      post_request(:path => '/v1/users/login_by_oauth', :body => params) do |async|
          response = JSON.parse(async.response)
          expect(response["error"]).to eq("failed to login weibo")
      end
    end
  end

  it 'login by oauth_token  : /v1/users/login_by_oauth' do
    with_api(ApplicationApi, api_options) do
      params = Hash.new
      params[:uid] = "2480188474"
      params[:oauth_type] = 0
      params[:oauth_token] = "2.00u_cqhCDvmhUCa8b99688ceeYP8SC"
      post_request(:path => '/v1/users/login_by_oauth', :body => params) do |async|
          response = JSON.parse(async.response)
          expect(response['name'].nil?).to eq(false)
          expect(response['last_login_at'].nil?).to eq(false) 
          access_token = response['access_token']
          expect(access_token['token'].length).to eq(36) 
          expect(access_token['key'].length).to eq(22) 
      end
    end
  end

  it 'login by oauth_token  : /v1/users/login_by_oauth' do
    with_api(ApplicationApi, api_options) do
      the_user = User.create(:password => SecureRandom.hex)
      the_user.save
      the_oauth_user = OauthUser.new
      the_oauth_user.user_id = the_user.id
      the_oauth_user.uid = "2480188474"
      the_oauth_user.oauth_type = 0
      the_oauth_user.save
      params = Hash.new
      params[:uid] = "2480188474"
      params[:oauth_type] = 0
      params[:oauth_token] = "2.00u_cqhCDvmhUCa8b99688ceeYP8SC"
      post_request(:path => '/v1/users/login_by_oauth', :body => params) do |async|
          response = JSON.parse(async.response)

          oauth_user = OauthUser.find_by(:uid => the_oauth_user.uid)
          expect(oauth_user.user.nick_name).to eq(response['name'])

          expect(response['last_login_at'].nil?).to eq(false)
          access_token = response['access_token']
          expect(access_token['token'].length).to eq(36) 
          expect(access_token['key'].length).to eq(22) 
      end
    end
  end

end
