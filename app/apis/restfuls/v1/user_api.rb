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
    	# * 创建账号（第三方登陆）
    	# == R
    	# * 获取验证码
    	# == Other
    	# * 登录帐号
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
		# ====== last_login_at:
		# 	上一次的登录时间(时间格式是 iso8601, "yyyy-MM-dd'T'HH:mm:ssZ")
		# ====== access_token:
		# ======== token:
		# 	用户的token
		# ======== key:
		# 	用户的key
		# ==== Response Body Example:
		# 		{
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
		#
		#
		# == 创建帐号（第三方登陆）
		# 	创建地推人员帐号（本接口暂时不开放）
	    # ==== POST
	    # 	/users
		# ==== Params
		# ====== phone_number:
		# 	手机号码
	    # ==== Response Status Code
		# 	201
	    # ==== Response Body
		# ====== last_login_at:
		# 	上一次的登录时间(时间格式是 iso8601, "yyyy-MM-dd'T'HH:mm:ssZ")
		# ====== access_token:
		# ======== token:
		# 	用户的token
		# ======== key:
		# 	用户的key
		# ==== Response Body Example:
		# 		{
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
		# ====== last_login_at:
		# 	上一次的登录时间(时间格式是 iso8601, "yyyy-MM-dd'T'HH:mm:ssZ")
		# ====== access_token:
		# ======== token:
		# 	用户的token
		# ======== key:
		# 	用户的key
		# ==== Response Body Example:
		# 		{
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
				new_user = User.new
				new_user.phone_number = params[:phone_number]
				new_user.password = params[:password]
				new_user.last_sign_in_at = Time.new
				begin
			        new_user.save
			    rescue Exception => e
					error!("Data is invaild", 501) 
			    end
			    new_user_token = new_user.generate_access_token
			    error!("Data is invaild", 501) if new_user_token.nil?
				present new_user, with: APIEntities::UserToken
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

		end

	end
end