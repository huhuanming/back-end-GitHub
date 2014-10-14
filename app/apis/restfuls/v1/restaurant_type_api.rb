module Restfuls
	##
	# 本接口用于餐厅类型列表方面

	class RestaurantTypev1 < Grape::API
		format :json

		##
		# 餐馆分类接口
		#
		# = 操作
		# == C
		# *
		# == U
		# *
		# == R
		# * 读取餐馆分类列表
		#
		#
		# == 读取餐馆分类列表
		# 	读取餐馆分类列表
	    # ==== GET
	    # 	/restaurant_types
	    # ==== Response Status Code
		# 	200
		# ==== Response Body
		# ====== restaurant_type:
		# 	餐馆类型 id
		# ====== restaurant_type_name:
		# 	餐馆类型名字
		# ==== Response Body Example:
	    #  [
		#	{
		#		restaurant_type: 1
		#		restaurant_type_name: "点菜"
		#	}
		#	{
		#		restaurant_type: 2
		#		restaurant_type_name: "面食"
		#	}
		#	{
		#		restaurant_type: 3
		#		restaurant_type_name: "炒饭"
		#	}
		#	{
		#		restaurant_type: 4
		#		restaurant_type_name: "盖浇"
		#	}
		#	{
		#		restaurant_type: 5
		#		restaurant_type_name: "饮料"
		#	}
		#	{
		#		restaurant_type: 6
		#		restaurant_type_name: "烧烤"
		#	}
		#  ]


		resource :restaurant_types do
			desc "get restaurant types"
			get do
				restaurant_types = RestaurantTypeName.all
				present restaurant_types, with: APIEntities::RestaurantTypeName
			end
		end
	end
end