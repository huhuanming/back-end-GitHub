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
		# * 读取餐馆订单
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
		# == 读取餐馆订单
		# 	读取餐馆订单
	    # ==== GET
	    # 	restaurants/{:restaurant_id}/orders
		# ==== Params
		# ====== {:restaurant_id}:
		# 	餐厅id
		# ====== access_token:
		# 	餐厅管理人员的 access_token
		# ====== page:
		# 	可选，页码，默认为1
		# ====== per_page:
		# 	可选，每页订单条数，默认为10
	    # ==== Response Status Code
		# 	200
	    # ==== Response Body
		# ====== order_id:
		# 	订单编号,注意，请使用字符串存储。
		# ====== ship_type:
		# 	快递方式，默认是 0。
		# ====== order_type:
		# 	订单状态，0 是未确认， 1 是已确认。
		# ====== phone_number:
		# 	下单人手机号
		# ====== shipping_user
		#  	收货人姓名
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
		# ==== Response Body Example:(page: 1,per_page: 2)
		# 	[
		#  		{
		# 			order_id: 1
		# 			ship_type: 0
	    # 			order_type: 0
		#			phone_number: "123"
		#			shipping_address: "哈哈1"
		#			total_price: "12.0"
		#			actual_total_price: "11.0"
		#			created_at: "2014-09-16T07:20:41Z"
		#			updated_at: "2014-09-16T10:20:41Z"
		#			shipping_at: "2014-09-16T10:20:41Z"
		#		},
		#		{
		#			order_id: 2
		#			ship_type: 0
		#			order_type: 0
		#			phone_number: "123"
		#			shipping_address: "哈哈2"
		#			total_price: "12.0"
		#			actual_total_price: "11.0"
		#			created_at: "2014-09-16T07:20:41Z"
		#			updated_at: "2014-09-16T10:20:41Z"
		#			shipping_at: "2014-09-16T10:20:41Z"
		#		}
		#	]
	    # ==== Error Status Code
		# ====== 401:
		# 	帐号验证错误，用户名或密码错误
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
				present:'response_status', 'successed to create a restaurant'
			end

			get ":restaurant_id/menu" do
				menu = FoodType.where(:restaurant_id => params[:restaurant_id])
				present menu, with: APIEntities::Menu
			end

			get ":restaurant_id/menus" do
				menu = FoodType.where(:restaurant_id => params[:restaurant_id])
				present menu, with: APIEntities::Menu
			end

			get ":restaurant_id/orders" do
				authenticate_supervisor!
				error!("supervisor is invaild", 401) if current_supervisor.restaurant_id.to_i != params[:restaurant_id].to_i
				order = Order.where(:restaurant_id => params[:restaurant_id]).paginate(:page => params[:page], :per_page => params[:per_page]||10)
				present order, with: APIEntities::Order
			end


			get ":restaurant_id/orders/:order_id" do
				authenticate_supervisor!
				error!("supervisor is invaild", 401) if current_supervisor.restaurant_id.to_i != params[:restaurant_id].to_i 
				order = Order.where(:restaurant_id => params[:restaurant_id]).paginate(:page => params[:page], :per_page => params[:per_page]||10)
				present order, with: APIEntities::Order
			end
		end
	end
end