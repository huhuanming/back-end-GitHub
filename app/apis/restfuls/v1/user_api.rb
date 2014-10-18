require 'net/https'
module Restfuls
	##
	# 本接口用于地推帐号的增删查改以及登录、充值密码等操作

	class Userv1 < Grape::API
		format :json

		##
		# 用户帐号接口
		#
		# = 操作
		# == C
		# * 创建帐号
		# * 创建收货地址
    	# == U
    	# * 更新收货地址
    	# * 更新默认收货地址
    	# == R
    	# * 获取验证码
    	# * 获取收货地址
    	# * 获取默认收货地址
    	# == D
    	# * 删除收货地址
    	# == Other
    	# * 登录帐号
    	# * 登陆账号（第三方登陆）
		#
		#
		# == 创建帐号
		# 	创建用户登陆账号
	    # ==== POST
	    # 	/users
		# ==== Params
		# ====== phone_number:
		# 	手机号码
		# ====== password:
		# 	密码（上传前请对密码进行 2 次 md5 算法）
		# ====== encryption_code:
		# 	调用 VerificationCode 类生成的加密串
	    # ==== Response Status Code
		# 	201
	    # ==== Response Body
		# ====== name:
		# 	用户名
		# ====== last_login_at:
		# 	上一次的登录时间(时间格式是 iso8601, "yyyy-MM-dd'T'HH:mm:ssZ")
		# ====== access_token:
		# ======== token:
		# 	用户的token
		# ======== key:
		# 	用户的key
		# ==== Response Body Example:
		# 		{
		#  			name: "打开方式有点不对啊"
		# 			last_login_at: "2014-08-30T10:02:17Z"
		# 			access_token: {
		# 				token: "a88257bc-16d0-47ac-8833-4b356e90d8a3"
		# 				key: "FG9K6bqS2OjtHM6EriAfUg"
		# 			}
		# 		}
	    # ==== Error Status Code
		# ====== 401:
		# 	帐号验证错误，用户名或密码错误
		# ====== 406:
		# 	连续输错 5 次验证码
		# ====== 501:
		# 	数据存储错误
		# ====== 502:
		# 	该手机号已被注册
		#
		# == 获取验证码
		# 	获取用户验证码
	    # ==== GET
	    # 	/users/mobile_verification_code
		# ==== Params
		# ====== phone_number:
		# 	手机号码
	    # ==== Response Status Code
		# 	200
	    # ==== Response Body
		# ====== response_status:
		# 	success to get it and please note that check your mobile phone
	    # ==== Error Status Code
		# ====== 403:
		# 	超过一天连续5次验证码的限制，24小时内不能再获取验证码
		# ====== 405:
		# 	等待一分钟后再次获取验证码
		#
		# == 创建收货地址
		# 	创建用户收货地址
	    # ==== POST
	    # 	/users/{:user_id}/addresses
		# ==== Params
		# ====== access_token:
		# 	用户的 access token
		# ====== shipping_user:
		# 	收货用户
		# ====== shipping_address:
		# 	收货地址
		# ====== phone_number:
		# 	手机号码
		# ====== is_default（可选）:
		# 	是否设置为默认收货地址
	    # ==== Response Status Code
		# 	201
	    # ==== Response Body
		# ====== response_status:
		# 	success to created
		#
		# == 更新收货地址
		# 	更新用户收货地址
	    # ==== PUT
	    # 	/users/{:user_id}/addresses/{:address_id}
		# ==== Params
		# ====== access_token:
		# 	用户的 access token
		# ====== shipping_user:
		# 	收货用户
		# ====== shipping_address:
		# 	收货地址
		# ====== phone_number:
		# 	手机号码
		# ====== is_default（可选）:
		# 	是否设置为默认收货地址
	    # ==== Response Status Code
		# 	200
	    # ==== Response Body
		# ====== response_status:
		# 	success to updated
		#
		# == 获取收货地址
		# 	获取用户收货地址
	    # ==== GET
	    # 	/users/{:user_id}/addresses
		# ==== Params
		# ====== access_token:
		# 	用户的 access token
	    # ==== Response Status Code
		# 	200
	    # ==== Response Body
		# ====== shipping_user:
		# 	收货人名字
		# ====== shipping_address:
		# 	收货地址
		# ====== phone_number:
		# 	收货人手机号
		# ====== is_default:
		# 	是否是默认收货地址
		# ==== Response Body Example:
		#	[
		#		{
		#			"shipping_user" : "2888",
  		#			"shipping_address" : "交大",
  		#			"phone_number" : "123456789",
  		#			"is_default" : "1"
  		#		},
		#		{
		#			"shipping_user" : "1234234",
  		#			"shipping_address" : "交大",
  		#			"phone_number" : "123456789",
  		#			"is_default" : "0"
  		#		}
  		#	]
		#
		#
		# == 获取默认收货地址
		# 	获取用户默认收货地址
	    # ==== GET
	    # 	/users/{:user_id}/addresses/default_address
		# ==== Params
		# ====== access_token:
		# 	用户的 access token
	    # ==== Response Status Code
		# 	200
	    # ==== Response Body
		# ====== shipping_user:
		# 	收货人名字
		# ====== shipping_address:
		# 	收货地址
		# ====== phone_number:
		# 	收货人手机号
		# ====== is_default:
		# 	是否是默认收货地址
		# ==== Response Body Example:
		#		{
		#			"shipping_user" : "2888",
  		#			"shipping_address" : "交大",
  		#			"phone_number" : "123456789",
  		#			"is_default" : "1"
  		#		}
  		#
  		#
		# == 删除收货地址
		# 	删除用户收货地址
	    # ==== DELETE
	    # 	/users/{:user_id}/addresses/{:address_id}
		# ==== Params
		# ====== access_token:
		# 	用户的 access token
	    # ==== Response Status Code
		# 	200
	    # ==== Response Body
		# ====== response_status:
		# 	success to deleted
		#
		# == 更新默认收货地址
		# 	更新默认收货地址
	    # ==== PUT
	    # 	/users/{:user_id}/addresses/{:address_id}/is_default
		# ==== Params
		# ====== access_token:
		# 	用户的 access token
	    # ==== Response Status Code
		# 	200
	    # ==== Response Body
		# ====== response_status:
		# 	this address was default
		#
		# == 登录帐号
		# 	登录用户帐号
	    # ==== POST
	    # 	/users/login
		# ==== Params
		# ====== username:
		# 	手机号码
		# ====== password:
		# 	帐号密码（上传前请对密码进行 2 次 md5 算法）
	    # ==== Response Status Code
		# 	201
	    # ==== Response Body
		# ====== name:
		# 	用户名
		# ====== last_login_at:
		# 	上一次的登录时间(时间格式是 iso8601, "yyyy-MM-dd'T'HH:mm:ssZ")
		# ====== access_token:
		# ======== token:
		# 	用户的token
		# ======== key:
		# 	用户的key
		# ==== Response Body Example:
		# 		{
		#  			name: "打开方式有点不对啊"
		# 			last_login_at: "2014-08-30T10:02:17Z"
		# 			access_token: {
		# 				token: "a88257bc-16d0-47ac-8833-4b356e90d8a3"
		# 				key: "FG9K6bqS2OjtHM6EriAfUg"
		# 			}
		# 		}
	    # ==== Error Status Code
		# ====== 401:
		# 	帐号验证错误，用户名或密码错误
		# ====== 501:
		# 	数据存储错误
		#
		# == 登陆账号（第三方登陆）
		# 	登录用户帐号
	    # ==== POST
	    # 	/users/login_by_oauth
		# ==== Params
		# ====== uid:
		# 	第三方账号体系中的用户唯一标识, 一般叫 uid
		# ====== oauth_token:
		# 	第三方账号登陆后获取的 Token
		# ====== oauth_type:
		# 	新浪微博为 0
	    # ==== Response Status Code
		# 	201
	    # ==== Response Body
		# ====== name:
		# 	用户名
		# ====== last_login_at:
		# 	上一次的登录时间(时间格式是 iso8601, "yyyy-MM-dd'T'HH:mm:ssZ")
		# ====== access_token:
		# ======== token:
		# 	用户的token
		# ======== key:
		# 	用户的key
		# ==== Response Body Example:
		# 		{
		#  			name: "打开方式有点不对啊"
		# 			last_login_at: "2014-08-30T10:02:17Z"
		# 			access_token: {
		# 				token: "a88257bc-16d0-47ac-8833-4b356e90d8a3"
		# 				key: "FG9K6bqS2OjtHM6EriAfUg"
		# 			}
		# 		}
	    # ==== Error Status Code
		# ====== 401:
		# 	用户 uid 和 token 不匹配，或在新浪微博 token 已失效
		# ====== 501:
		# 	数据存储错误
		resource :users do

			desc "Create a customer account"
			params do
				requires :phone_number, type: String
				requires :password, type: String
				requires :encryption_code, type: String
			end
			post do
				user_mobile_verification = UserMobileVerification.find_by(:phone_number => params[:phone_number])
				error!("Verification code is not found with the phone number", 404) if user_mobile_verification.nil?
				error!("Only can try 5 times in 24 hours", 406) if user_mobile_verification.is_valid?
				error!("Verification code is invalid", 401) if user_mobile_verification.not_verify?(params[:encryption_code])
				error!("Phone number is exist", 502) if User.find_by(:phone_number => params[:phone_number])
				new_user = User.new
				new_user.phone_number = params[:phone_number]
				new_user.nick_name = params[:phone_number]
				new_user.password = params[:password]
				new_user.update_tracked_fields!(request)
				begin
			        new_user.save
			    rescue Exception => e
					error!("Data is invalid", 501) 
			    end
			    new_user_token = new_user.generate_access_token
			    error!("Data is invalid", 501) if new_user_token.nil?
				present new_user, with: APIEntities::UserToken
			end

			desc "bind push id and user"
			params do
				requires :push_id, type: String
				requires :access_token, type: String
			end
			post "/bind_push" do
				authenticate_user!
				UserPush.create(:user_id => current_user.id, :push_id => params[:push_id])
				present:"response_status", "success to bind"
			end

			desc "Login customer account with third party oauth service"
			params do
				requires :uid, type: String
				requires :oauth_token, type: String
				requires :oauth_type, type: String
			end
			post '/login_by_oauth' do
				uri = URI.parse("https://api.weibo.com/2/users/show.json")
				
				http_params = Hash.new
				http_params["appkey"] = "2285991897"
				http_params["access_token"] = params[:oauth_token]
				http_params["uid"] = params[:uid]
				uri.query = URI.encode_www_form(http_params)
				http = Net::HTTP.new(uri.host, uri.port)
				http.use_ssl = true
				http.verify_mode = OpenSSL::SSL::VERIFY_NONE
				http_request = Net::HTTP::Get.new(uri.request_uri)

				response = JSON.parse(http.request(http_request).body)

				error!("failed to login weibo", 401) if response["id"].nil?

				the_oauth_user = OauthUser.find_by(:uid => params["uid"])
				if the_oauth_user.nil?
				    the_user = User.create(:password => SecureRandom.hex)
				    the_user.save
				    the_oauth_user = OauthUser.new
				    the_oauth_user.user_id = the_user.id
				    the_oauth_user.uid = params["uid"]
				    the_oauth_user.oauth_type = params[:oauth_type]
				    the_oauth_user.save
				else
				    the_user = the_oauth_user.user
				end
				
				the_user.nick_name = response["name"]
				the_user.save
				the_user.update_tracked_fields!(request)
				the_user_token = the_user.generate_access_token
				error!("Data is invalid", 501) if the_user_token.nil?
				present the_user, with: APIEntities::UserToken
			end

			desc "Login customer account"
			params do
				requires :username, type: String
				requires :password, type: String
			end
			post '/login' do
				this_user = User.login(request)
				error!("Username or password is invalid", 401) if this_user.nil?
				this_user_token = this_user.generate_access_token
				error!("Data is invalid", 501) if this_user_token.nil?
				present this_user, with: APIEntities::UserToken
			end

			desc "Get a mobile verification code"
			params do
				requires :phone_number, type: String
			end
			get '/mobile_verification_code' do
				user_mobile_verification = UserMobileVerification.find_or_initialize_by(:phone_number => params[:phone_number])
				error!("Can't get verification code in 24 hours", 403) if user_mobile_verification.is_valid?
				error!("Wait 1 minute to get verification_code", 405) if !user_mobile_verification.send_verification_code
				present:"response_status", "success to get it and please note that check your mobile phone"
			end

			desc "create a delivery address for user"
			params do
				requires :access_token, type: String
				requires :shipping_user, type: String
				requires :shipping_address, type: String
				requires :phone_number, type: String
				optional :is_default, type: Integer, default: 0
			end
			post ':user_id/addresses' do
				authenticate_user!
				error!("access_token is invalid", 401) if params[:user_id].to_i != current_user.id
				this_address = UserAddress.new(
										 		:user_id => params[:user_id],
										 		:shipping_user => params[:shipping_user],
										 		:shipping_address => params[:shipping_address],
										 		:phone_number => params[:phone_number],
										 		:is_default => params[:is_default]
										 	)
				this_address.is_default = 1	if UserAddress.where(:user_id => params[:user_id]).size < 1
				if params[:is_default] == 1
					address_with_default = UserAddress.where(:user_id => params[:user_id])
													  .where(:is_default => 1)
													  .first
					if !address_with_default.nil?
						address_with_default.is_default = 0
						address_with_default.save
					end
				end
				this_address.save
				present:'response_status', 'success to created'
			end

			desc "updated a delivery address for user"
			params do
				requires :access_token, type: String
				requires :shipping_user, type: String
				requires :shipping_address, type: String
				requires :phone_number, type: String
				optional :is_default, type: Integer, default: 0
			end
			put ':user_id/addresses/:address_id' do
				 authenticate_user!
				 this_user = current_user
				 error!("access_token is invalid", 401) if params[:user_id].to_i != this_user.id
				 this_address = UserAddress.find_by_id(params[:address_id])
				 error!("access_token is invalid", 401) if this_address.nil? || this_address.user_id != params[:user_id].to_i
				 this_address.shipping_user = params[:shipping_user]
				 this_address.shipping_address = params[:shipping_address]
				 this_address.phone_number = params[:phone_number]
				 this_address.is_default = params[:is_default]
				 if params[:is_default] == 1
					address_with_default = UserAddress.where(:user_id => params[:user_id])
													  .where(:is_default => 1)
													  .first
					if !address_with_default.nil?
						address_with_default.is_default = 0
						address_with_default.save
					end
				  end
				 this_address.save
				 present:'response_status', 'success to updated'
			end

			desc "get a user profile"
			params do
				requires :access_token, type: String
			end
			get ':user_id/profile' do
				 authenticate_user!
				 present current_user, with: APIEntities::UserProfile
			end

			desc "read delivery addresses for user"
			params do
				requires :access_token, type: String
			end
			get ':user_id/addresses' do
				 authenticate_user!
				 this_user = current_user
				 error!("access_token is invalid", 401) if params[:user_id].to_i != this_user.id
				 addresses = UserAddress.where(:user_id => params[:user_id])
				 present addresses, with: APIEntities::UserAddress
			end


			desc "get default delivery addresses for user"
			params do
				requires :access_token, type: String
			end
			get ':user_id/addresses/default_address' do
				 authenticate_user!
				 this_user = current_user
				 error!("access_token is invalid", 401) if params[:user_id].to_i != this_user.id
				 addresses = UserAddress.where(:user_id => params[:user_id])
													  .where(:is_default => 1)
													  .first
				 present addresses, with: APIEntities::UserAddress
			end


			desc "delete a delivery address for user"
			params do
				requires :access_token, type: String
			end
			delete ':user_id/addresses/:address_id' do
				 authenticate_user!
				 this_user = current_user
				 error!("access_token is invalid", 401) if params[:user_id].to_i != this_user.id
				 this_address = UserAddress.find_by_id(params[:address_id])
				 error!("this address is not invalid", 401) if this_address.user_id != params[:user_id].to_i
				 this_address.delete
				 present:'response_status', 'success to deleted'
			end


			desc "updated a delivery address's is_default value"
			params do
				requires :access_token, type: String
			end
			put ':user_id/addresses/:address_id/is_default' do
				 authenticate_user!
				 this_user = current_user
				 error!("access_token is invalid", 401) if params[:user_id].to_i != this_user.id
				 this_address = UserAddress.find_by_id(params[:address_id])
				 error!("access_token is invalid", 401) if this_address.user_id != params[:user_id].to_i

				address_with_default = UserAddress.where(:user_id => params[:user_id])
									 				  .where(:is_default => 1)
													  .first
				if address_with_default.nil?
					address_with_default.is_default = 0
					address_with_default.save
				end
				this_address.is_default = 1
				this_address.save
			    present:'response_status', 'this address was default'
			end

		end
	end
end