module Restfuls
	##
	# 与服务器 v1 版接口进行连接，测试服务器是否能正常工作
	class Orderv1 < Grape::API
    	format :json
		##
		# 订单接口
		#
		# = 操作
		# * 创建订单（测试接口，不开放）
		# * 读取订单
		#
		# == 读取订单
		# 	读取餐厅订单
	    # ==== GET
	    # 	/orders
		# ==== Params
		# ====== access_token:
		# 	餐厅管理人员的 access_token
		# ====== page:
		# 	可选，页码，默认为0
		# ====== per_page:
		# 	可选，每页订单条数，默认为10
	    # ==== Response Status Code
		# 	200
	    # ==== Response Body
		# ====== response_status:
		# 	'successed to create order of this restaurant'
	    # ==== Error Status Code
		# ====== 401:
		# 	帐号验证错误，用户名或密码错误
		# ====== 501:
		# 	数据库存储错误
		# ====== 502:
		# 	menu_json格式错误
		resource :orders do
			desc "Create a order"
			get do
				authenticate_supervisor!
				order = Order.where(:restaurant_id => current_supervisor.restaurant_id).page(params[:page])
				# order = Order.where(:restaurant_id => current_supervisor.restaurant_id).page(params[:page]).per(params[:per_page]||10)
				present order, with: APIEntities::Order
			end
		end
	end
end