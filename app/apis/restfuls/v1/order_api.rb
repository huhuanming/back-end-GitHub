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
		#
		# == 创建订单
		# 	为餐厅创建一份订单
	    # ==== POST
	    # 	/menus
		# ==== Params
		# ====== access_token:
		# 	餐厅管理人员的 access_token
		# ====== order_good_json:
		# 	菜单的json数据,格式如下:
		#   {"菜品一":{"青菜":{"price":"3.00"},"白菜":{"price":"2:00"}},"菜品二":{"紫菜":{"price":"2.00"},"花菜":{"price":"1:00"}}}
	    # ==== Response Status Code
		# 	201
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
	end
end