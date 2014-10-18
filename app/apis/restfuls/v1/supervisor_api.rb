module Restfuls
	##
	# 本接口用于餐厅管理员帐号的增删查改以及登录、充值密码等操作
	class Supervisorv1 < Grape::API
		format :json
		##
		# 餐厅管理员帐号接口
		#
		# = 操作
    	# * 登录帐号
		#
		# == 登录帐号
		# 	登录餐厅管理员帐号
	    # ==== POST
	    # 	/supervisors/login
		# ==== Params
		# ====== username:
		# 	手机号码
		# ====== password:
		# 	帐号密码(初始密码，手机号后四位)
	    # ==== Response Status Code
		# 	201
	    # ==== Response Body
		# ====== login_count:
		# 	餐厅管理员的登录次数
		# ====== last_login_at:
		# 	上一次的登录时间(时间格式是 iso8601, "yyyy-MM-dd'T'HH:mm:ssZ")
		# ====== access_token:
		# ======== token:
		# 	餐厅管理员的token
		# ======== key:
		# 	餐厅管理员的key
		# ====== restaurant:
		# ======== restaurant_id:
		# 	餐馆的id
		# ======== restaurant_name:
		# 	餐馆的名字
		# ==== Response Body Example:
		# 		{
		# 			login_count: 3
		# 			last_login_at: "2014-08-30T10:02:17Z"
		# 			access_token: {
		# 				token: "a88257bc-16d0-47ac-8833-4b356e90d8a3"
		# 				key: "FG9K6bqS2OjtHM6EriAfUg"
		# 			}
		# 			restaurant: {
		# 	           restaurant_id: 1
		# 			   restaurant_name: "这个店很奇怪"
		# 		}
	    # ==== Error Status Code
		# ====== 401:
		# 	帐号验证错误，用户名或密码错误
		# ====== 501:
		# 	数据存储错误
		resource :supervisors do

			desc "Login supervisor account"
			post '/login' do
				supervisor = Supervisor.login(request)
				error!("Username or password is invalid", 401) if supervisor.nil?
				supervisor_token = supervisor.generate_access_token
				error!("Data is invaild", 501) if supervisor_token.nil?
				present supervisor, with: APIEntities::Supervisor
			end

			desc "bind push id and supervisor"
			params do
				requires :push_id, type: String
				requires :access_token, type: String
			end
			post "/bind_push" do
				authenticate_supervisor!
				SupervisorPush.create(:user_id => current_supervisor.id, :push_id => params[:push_id])
				present:"response_status", "success to bind"
			end

		end
	end
end