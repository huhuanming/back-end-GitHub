module Restfuls
	##
	# 本接口用于地推帐号的增删查改以及登录、充值密码等操作

	class Userv1 < Grape::API
		format :json

		##
		# 地推人员帐号接口
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
		# 	创建地推人员帐号（本接口暂时不开放）
	    # ==== POST
	    # 	/users
		# ==== Params
		# ====== phonenumber:
		# 	手机号码
	    # ==== Return
		# ====== p_token:
		# 	返回地推人员帐号的 token
		#
		# == 创建帐号（第三方登陆）
		# 	创建地推人员帐号（本接口暂时不开放）
	    # ==== POST
	    # 	/users
		# ==== Params
		# ====== phonenumber:
		# 	手机号码
	    # ==== Return
		# ====== p_token:
		# 	返回地推人员帐号的 token
		#
		# == 登录帐号
		# 	登录地推人员帐号
	    # ==== POST
	    # 	/users/login
		# ==== Params
		# ====== username:
		# 	手机号码
		# ====== password:
		# 	帐号密码
	    # ==== Response Status Code
		# 	201
	    # ==== Response Body
		# ====== token:
		# 	返回地推人员帐号的 token
		# ====== key:
		# 	返回地推人员帐号的 key
	    # ==== Error Status Code
		# ====== 401:
		# 	帐号验证错误，用户名或密码错误
		# ====== 501:
		# 	数据存储错误
		resource :users do
			
			desc "Create a customer account"
			post do	
				present:p_token, token
			end

			desc "Login customer account"
			post '/login' do
				promotioner = Promotioner.login(request)
				error!("Username or password is invalid", 401) if promotioner.nil?
				promotioner_token = promotioner.generate_access_token
				error!("Data is invaild", 501) if promotioner_token.nil?
				present promotioner_token, with: APIEntities::AccessToken
			end

			desc "Get a mobile verification code"
			get '/mobile_verification_code' do
				user_mobile_verification = UserMobileVerification.find_or_initialize_by(:phone_number => params[:phone_number])
				error!("Only 5 times in every day to get mobile verification code", 402) if user_mobile_verification.is_valid?
				user_mobile_verification.send_verification_code
				present:"response_status", "success to get it and please note that check your mobile phone"
			end

		end

	end
end