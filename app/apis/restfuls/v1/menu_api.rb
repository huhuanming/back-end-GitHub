module Restfuls
	##
	# 本接口用于餐厅菜单的增删查改以及登录、充值密码等操作

	class Menuv1 < Grape::API
		format :json

		##
		# 餐厅菜单接口
		#
		# = 操作
		# * 创建餐单
		#
		# == 创建餐单
		# 	为餐厅创建一份菜单
	    # ==== POST
	    # 	/menus
		# ==== Params
		# ====== access_token:
		# 	餐厅管理人员的 access_token
		# ====== menu_json:
		# 	菜单的json数据,格式如下:
		#   {"菜品一":{"青菜":{"price":"3.00"},"白菜":{"price":"2.00"}},"菜品二":{"紫菜":{"price":"2.00"},"花菜":{"price":"1.00"}}}
	    # ==== Response Status Code
		# 	201
	    # ==== Response Body
		# ====== response_status:
		# 	'successed to update menu of this restaurant'
	    # ==== Error Status Code
		# ====== 401:
		# 	帐号验证错误，用户名或密码错误
		# ====== 501:
		# 	数据库存储错误
		# ====== 502:
		# 	menu_json格式错误
		resource :menus do
			desc "Create or update food menu for this restaurant"
			post do	
				authenticate_supervisor!
				restaurant_id = current_supervisor.restaurant.id
				begin
			        menu = JSON.parse(params[:menu_json])
			    rescue Exception => e
			        error!("menu_json is invalid", 502)
			    end

			    begin
			       types = menu.keys
			    rescue Exception => e
			        error!("menu_json is invalid", 502)
			    end
				
				types.each do |type_name|
					the_type = FoodType.find_or_initialize_by(:type_name => type_name)
					if the_type.restaurant_id.nil? || the_type.restaurant_id != restaurant_id
						the_type = FoodType.new
						the_type.type_name = type_name
						the_type.restaurant_id = restaurant_id
						the_type.save
					end
					the_food_of_type = menu[type_name]
				    begin
				       	food_names = the_food_of_type.keys
				    rescue Exception => e
				        error!("menu_json is invalid", 502)
				    end
					food_names.each do |food_name|
						food = the_food_of_type[food_name]
						the_food = Food.find_or_initialize_by(:food_name => food_name)
						the_food.food_type_id = the_type.id
						price = food["price"]
						error!("menu_json is invalid", 502) if price.nil?
						the_food.shop_price = price
						the_food.save
					end
					Food.where(:food_type_id => the_type.id).where.not(:food_name => food_names).delete_all
				end
				ids = FoodType.where(:restaurant_id => restaurant_id).where.not(:type_name => types).pluck(:id)
				if ids.length > 0
					Food.where(:food_type_id => ids).delete_all
					FoodType.where(:id => ids).delete_all
				end
				present:'response_status', 'successed to update menu of this restaurant'
			end

		end

	end
end