module Restfuls
	##
	# 本接口用于餐厅方面

	class Restaurantv1 < Grape::API
		format :json

		##
		# 餐馆接口
		#
		# = 操作
		# * 创建餐馆
		# * 读取餐馆菜单
		# * 读取餐馆订单列表
		# * 读取餐馆某条订单
		# * 确认餐馆某条订单
		#
		#
		# == 创建餐馆
		# 	创建一家餐馆，并生成一个商家帐号，商家登录帐号为他填写的手机号，登录密码为手机号后四位
	    # ==== POST
	    # 	/restaurants
		# ==== Params
		# ====== access_token:
		# 	地推人员 access_token
		# ====== restaurant_name:
		# 	餐馆名称
		# ====== supervisor_name
		# 	餐馆老板名称
		# ====== back_account:
		# 	银行帐号
		# ====== phone_number:
		# 	餐馆联系电话（餐馆经营者手机号码）
		# ====== linsece:
		# 	餐馆的营业执照
		# ====== id_card_front:
		# 	身份证正面照片
		# ====== id_card_reverse:
		# 	身份证背面照片
		# ====== address:
		# 	餐馆地址
		# ====== radius:
		# 	送餐半径，单位是米
		# ====== longitude:
		# 	餐馆坐标经度
		# ====== latitude:
		# 	餐馆坐标纬度
		# ====== coordinate_x1:
		# 	餐馆x1坐标
		# ====== coordinate_x2:
		# 	餐馆x2坐标
		# ====== coordinate_y1:
		# 	餐馆y1坐标
		# ====== coordinate_y2:
		# 	餐馆y2坐标
	    # ==== Response Status Code
		# 	201
		# ==== Response Body
		# ====== response_status:
		# 	"successed to create a restaurant"(字符串)
	    # ==== Error Status Code
		# ====== 401:
		# 	地推帐号验证错误，AccessToken 过期、无效
		# ====== 404:
		# 	地推帐号 AccessToken 不存在
		# ====== 501:
		# 	数据存储错误
		# 
		# 
		# == 读取餐馆菜单
		# 	读取指定餐馆的菜单
	    # ==== GET
	    # 	restaurants/{:restaurant_id}/menus
		# ==== Params
		# ====== {:restaurant_id}
		# 	餐馆的id
	    # ==== Response Status Code
		# 	200
		# ==== Response Body
		# ====== type_name:
		# 	菜品种类名
		# ====== foods:
		# ======== food_name:
		# 	菜名
		# ======== shop_price:
		# 	销售价格
		# ==== Response Body Example:
	    # 	[
	    #     {
	    # 		"type_name":"菜品二",
	    # 		"foods":
	    # 		[
	    # 			{
	    # 				"food_name":"翔啊",
	    # 				"shop_price":"3.0"
	   	# 			},
	    # 			{
	    # 				"food_name":"鐧借彍",
	    # 				"shop_price":"2.0"
	    # 			}
	    # 		]
	    #  	 },
	    # 	 {
	    # 		"type_name":"翔类",
	    # 		"foods":
	    # 		[
	    # 			{
	    # 				"food_name":"好菜",
	    # 				"shop_price":"2.0"
	    # 			},
	    # 			{
	    # 				"food_name":"花菜",
	    # 				"shop_price":"1.0"
	    # 			}
	    # 		]
	    # 	 }
	    #  ]
		# 
		# == 读取餐馆订单列表
		# 	读取餐馆订单列表
	    # ==== GET
	    # 	restaurants/{:restaurant_id}/orders
		# ==== Params
		# ====== {:restaurant_id}:
		# 	餐厅id
		# ====== access_token:
		# 	餐厅管理人员的 access_token
		# ====== id:
		# 	可选，订单编号，默认为当前订单最大编号 
		# ====== count:
		# 	可选，显示条数，默认为 10
	    # ==== Response Status Code
		# 	200
	    # ==== Response Body
		# ====== order_id:
		# 	订单编号。
		# ====== ship_type:
		# 	快递方式，默认是 0。
		# ====== order_type:
		# 	订单状态，0 是未确认， 1 是已确认。
		# ====== phone_number:
		# 	下单人手机号
		# ====== phone_number:
		# 	下单人手机号
		# ====== order_remark
		#  	订单备注
		# ====== shipping_address:
		# 	收货地址
		# ====== food_count:
		# 	预订的的菜品个数
		# ====== total_price:
		# 	订单总价
		# ====== actual_total_price:
		# 	订单实际总价
		# ====== created_at:
		# 	订单创建时间(时间格式 iso8601, "yyyy-MM-dd'T'HH:mm:ssZ")
		# ====== updated_at:
		# 	订单更新时间(时间格式 iso8601, "yyyy-MM-dd'T'HH:mm:ssZ")
		# ====== shipping_at:
		# 	预计收货时间(时间格式 iso8601, "yyyy-MM-dd'T'HH:mm:ssZ")
		# ==== Response Body Example:(id: 3,count: 2)
		# 	[
		#  		{
		# 			order_id: 2
		#			ship_type: 0
		#			order_type: 0
		#			phone_number: "12.00000"
		#			food_count: 2
		#			shipping_user: "哈哈1"
		#			shipping_address: "123"
		#  			order_remark: "无"
		#			total_price: "11.0"
		#			actual_total_price: "2014.0"
		#			created_at: "2014-09-16T10:20:41Z"
		#			updated_at: "2014-09-16T10:20:41Z"
		#			shipping_at: "2014-09-16T10:20:41Z"
		#		},
		#		{
		#			order_id: 1
		#			ship_type: 0
		#			order_type: 0
		#			phone_number: "12.00000"
		#			food_count: 2
		#			shipping_user: "哈哈2"
		#			shipping_address: "123"
		#  			order_remark: "无"
		#			total_price: "11.0"
		#			actual_total_price: "2014.0"
		#			created_at: "2014-09-16T10:20:41Z"
		#			updated_at: "2014-09-16T10:20:41Z"
		#			shipping_at: "2014-09-16T10:20:41Z"
		#		}
		#	]
	    # ==== Error Status Code
		# ====== 401:
		# 	帐号验证错误，用户名或密码错误
		# 
		# == 读取餐馆某条订单
		# 	读取餐馆某条订单
	    # ==== GET
	    # 	restaurants/{:restaurant_id}/orders/{:order_id}
		# ==== Params
		# ====== {:restaurant_id}:
		# 	餐厅id
		# ====== {:order_id}:
		# 	订单id
		# ====== access_token:
		# 	餐厅管理人员的 access_token
	    # ==== Response Status Code
		# 	200
	    # ==== Response Body
		# ====== count:
		# 	菜品个数
		# ====== total_price:
		# 	当前菜品总价
		# ====== actual_total_price:
		# 	当前菜品实际总价
		# ====== food:
		# ======= food_name:
		#   菜品名字
		# ======= shop_price:
		#   菜品价格
		# ==== Response Body Example:
		#	[
		#		{
		#			count: 4
		#			total_price: "180.0"
		#			actual_total_price: "180.0"
		#			food: 
		#			{
		#				food_name: "nbb"
		#				shop_price: "5.0"
		#			}
		#		},
		#		{
		#			count: 4
		#			total_price: "180.0"
		#			actual_total_price: "180.0"
		#			food: 
		#			{
		#				food_name: "克隆"
		#				shop_price: "5.0"
		#			}
		#		}
		#	]
		# ====== 401:
		# 	帐号验证错误，用户名或密码错误
		#
		# == 确认餐馆某条订单
		# 	确认餐馆某条订单
	    # ==== PUT
	    # 	restaurants/{:restaurant_id}/orders/{:order_id}/check_order
		# ==== Params
		# ====== {:restaurant_id}:
		# 	餐厅id
		# ====== {:order_id}:
		# 	订单id
		# ====== access_token:
		# 	餐厅管理人员的 access_token
	    # ==== Response Status Code
		# 	200
	    # ==== Response Body
		# ====== response_status:
		# 	"This order was checked"
		# ====== 401:
		# 	帐号验证错误，用户名或密码错误
		# ====== 404:
		# 	没有找到相应的订单
		resource :restaurants do
			desc "Create a restaurant"
			post do	
				authenticate_promotioner!
				promotioner = current_promotioner
				restaurant = Restaurant.new(
						'promotioner_id' => promotioner.id,
						'restaurant_name' => params[:restaurant_name],
						'back_account' => params[:back_account],
						'phone_number' => params[:phone_number],
						'zone_id' => promotioner.zone_id
					)
				begin
			        restaurant.save
			    rescue Exception => e
			        error!("Data is invalid or exist", 501)
			    end
				restaurant_linsece = RestaurantLinsece.new(
						'restaurant_id' => restaurant.id,
						'linsece' => params[:linsece],
						'id_card_front' => params[:id_card_front],
						'id_card_reverse' => params[:id_card_reverse]
					)
				begin
			        restaurant_linsece.save
			    rescue Exception => e
			    	restaurant.delete
			        error!("Data is invalid or exist", 501)
			    end
				restaurant_address = RestaurantAddress.new(
						'restaurant_id' => restaurant.id,
						'address' => params[:address],
						'radius' => params[:radius],
						'longitude' => params[:longitude],
						'latitude' => params[:latitude],
						'coordinate_x1' => params[:coordinate_x1],
						'coordinate_x2' => params[:coordinate_x2],
						'coordinate_y1' => params[:coordinate_y1],
						'coordinate_y2' => params[:coordinate_y2],
					)
				begin
			        restaurant_address.save
			    rescue Exception => e
			    	restaurant.delete
			    	restaurant_linsece.delete
			        error!("Data is invalid or exist", 501)
			    end

			    string_length = params[:phone_number].to_s.length
			    supervisor_password = params[:phone_number].to_s[string_length-4,string_length-1]
				supervisor = Supervisor.new(
						'restaurant_id' => restaurant.id,
						'phone_number' => params[:phone_number],
						'nick_name' => params[:supervisor_name],
						'password' => supervisor_password
					)

				begin
			        supervisor.save
			    rescue Exception => e
			    	restaurant.delete
					restaurant_linsece.delete
					restaurant_address.delete
					error!("Data is invaild", 501) 
			    end


				begin
			        RestaurantStatus.create(:restaurant_id => restaurant.id, :shipping_phone_number => params[:phone_number])
			    rescue Exception => e
			    	supervisor.delete
			    	restaurant.delete
					restaurant_linsece.delete
					restaurant_address.delete
					error!("Data is invaild", 501) 
			    end
				present:'response_status', 'successed to create a restaurant'
			end

			get ":restaurant_id/menu" do
				menu = FoodType.where(:restaurant_id => params[:restaurant_id])
				present menu, with: APIEntities::Menu
			end

			get ":restaurant_id/menus" do
				menus = FoodType.where(:restaurant_id => params[:restaurant_id])
				present menus, with: APIEntities::Menu
			end

			get ":restaurant_id/orders" do
				authenticate_supervisor!
				error!("supervisor is invaild", 401) if current_supervisor.restaurant_id.to_i != params[:restaurant_id].to_i
				order = Order.where(:restaurant_id => params[:restaurant_id]).where("id < ?", params[:id]|| (Order.last.id+1)).limit(params[:count]||10).order(id: :desc)
				present order, with: APIEntities::Order
			end


			get ":restaurant_id/orders/:order_id" do
				authenticate_supervisor!
				error!("supervisor is invaild", 401) if current_supervisor.restaurant_id.to_i != params[:restaurant_id].to_i 
				order_foods = OrderFood.where(:order_id => params[:order_id])
				present order_foods, with: APIEntities::OrderFood
			end

			# 确认订单
			put ":restaurant_id/orders/:order_id/check_order" do
				authenticate_supervisor!
				error!("supervisor is invaild", 401) if current_supervisor.restaurant_id.to_i != params[:restaurant_id].to_i 
				order = Order.find_by(:id => params[:order_id])
				error!("not found", 404) if order.nil?
				order.order_type = 1
				order.save
				present:'response_status', 'This order was checked'
			end

			get ":restaurant_id/status" do
				authenticate_supervisor!
				error!("supervisor is invaild", 401) if current_supervisor.restaurant_id.to_i != params[:restaurant_id].to_i 
				restaurant_status = RestaurantStatus.find_by(:restaurant_id => params[:restaurant_id])
				present restaurant_status, with: APIEntities::RestaurantStatus
			end
		end
	end
end