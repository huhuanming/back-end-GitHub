module Restfuls
	##
	# 本接口用于地推帐号的增删查改以及登录、充值密码等操作

	class Promotionerv1 < Grape::API
		format :json

		helpers PromotionerHelper
		##
		# 地推人员帐号接口
		#
		# = 操作
		# * 创建帐号
    	# * 删除帐号
    	# * 登录帐号
		#
		#
		# == 创建帐号
		# 	创建地推人员帐号（本接口暂时不开放）
	    # ==== POST
	    # 	/promotioners
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
	    # 	/promotioners/login
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
		resource :promotioners do
			
			desc "Create a promotioner account"
			post do	
				authenticate_promotioner!
				present:p_token, token
			end

			desc "Login promotioner account"
			post '/login' do
				promotioner = Promotioner.login(request)
				error!("Username or password is invalid", 401) if promotioner.nil?
				promotioner_token = promotioner.generate_access_token
				error!("Data is invaild", 501) if promotioner_token.nil?
				present promotioner_token, with: APIEntities::AccessToken
			end


		end

	end
end