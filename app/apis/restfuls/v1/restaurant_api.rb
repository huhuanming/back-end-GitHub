module Restfuls
	##
	# 本接口用于餐厅方面

	class Restaurantv1 < Grape::API
		format :json

		##
		# 餐馆接口
		#
		# = 操作
		# == C
		# * 创建餐馆
		# == U
		# * 确认餐馆某条订单
		# * 更新餐馆开店状态
		# * 更新餐馆关店时间
		# * 更新餐馆公告
		# * 更新餐馆起送价
		# * 更新餐馆送餐费
		# * 更新餐馆配送时间
		# * 更新餐馆送餐电话
		# * 更新餐馆短信接单状态
		# * 更新餐馆客户端接单状态
		# == R
		# * 读取餐馆列表
		# * 读取餐馆资料
		# * 读取餐馆基本信息
		# * 读取餐馆菜单
		# * 读取餐馆订单列表
		# * 读取餐馆设置
		# * 读取餐馆某条订单
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
		# == 读取餐馆列表
		# 	根据你当前的位置获取附近的餐馆
	    # ==== GET
	    # 	/restaurants
		# ==== Params
		# ====== longitude:
		# 	你当前位置的经度
		# ====== latitude:
		# 	你当前位置的纬度
		# ====== order_type(可选)
		# 	默认为 0. 1 代表 配送时间最短， 2 代表 配送距离最短， 3 代表 配送费最便宜
		# ====== restaurant_type(可选）
		# 	默认为 0. 暂不开放
		# ====== page(可选)
		# 	默认为 0.  获取的数据页数
		# ====== count(可选）
		# 	默认为 10. 每页的数据条数
	    # ==== Response Status Code
		# 	200
		# ==== Response Body
		# ====== rid:
		# 	餐馆 id
		# ====== name:
		# 	餐馆名字
		# ====== avatar:
		# 	餐馆头像
		# ====== status:
		# ======== start_shipping_fee:
		#   免运费起送价
		# ======== shipping_time:
		#   配送时间
		# ==== Response Body Example:
	    # 	[
		#		{
		#			rid: 10
		#			name: "懒洋洋绝味面"
		#			avatar: "restaurant_avatar"
		#			status: {
		#				start_shipping_fee: "10.0"
		#				shipping_time: 10
		#			}
		#		}
		#		{
		#			rid: 11
		#			name: "王记简阳老字号羊肉"
		#			avatar: "restaurant_avatar"
		#			status: {
		#				start_shipping_fee: "10.0"
		#				shipping_time: 10
		#			}
		#		}
	    #  ]
		# 
		# == 读取餐馆资料
		#   读取单个餐馆的资料
		# === GET
	    # 	restaurants/{:restaurant_id}
		# ==== Params
		# ====== {:restaurant_id}
		# 	餐馆的 rid
	    # ==== Response Status Code
		# 	200
		# ==== Response Body
		# ====== rid:
		# 	餐馆 rid
		# ====== name:
		# 	餐馆名字
		# ====== avatar:
		# 	餐馆头像
		# ====== phone_number:
		# 	餐馆电话号码
		# ====== restaurant_address:
		# ======== address:
		# 	餐馆详细地址
		# ======== radius:
		# 	餐馆送餐半径
		# ====== restaurant_address:
		# ======== start_shipping_fee:
		# 	免运费起送费
		# ======== shipping_time:
		# 	送餐时间
		# ======== shipping_fee:
		# 	送餐运费
		# ======== board:
		# 	餐馆公告
		# ====== restaurant_type:
		# ======== restaurant_type_name:
		# ========== type_name:
		# 	餐馆类型名字
		# ==== Response Body Example:
		#	{
		#		rid: 10
		#		name: "懒洋洋绝味面"
		#		avatar: "restaurant_avatar"
		#		phone_number: "13538381054"
		#		restaurant_address: {
		#			address: "成都犀浦校园路93附24"
		#			radius: 500
		#		}
		#		restaurant_status: {
		#			start_shipping_fee: "10.0"
		#			shipping_time: 10
		#			shipping_fee: "5.0"
		#			board: "欢迎光临"
		#		}
		#		restaurant_type: [
		#			{
		#				restaurant_type_name: {
		#					type_name: "面食"
		#				}
		#			}
		#			{
		#				restaurant_type_name: {
		#					type_name: "炒饭"
		#				}
		#			}
		#			{
		#				restaurant_type_name: {
		#					type_name: "盖浇"
		#				}
		#			}
		#		]
		#	}
		#
		# 
		# == 读取餐馆菜单
		# 	读取指定餐馆的菜单
	    # ==== GET
	    # 	restaurants/{:restaurant_id}/menus
		# ==== Params
		# ====== {:restaurant_id}
		# 	餐馆的rid
	    # ==== Response Status Code
		# 	200
		# ==== Response Body
		# ====== type_name:
		# 	菜品种类名
		# ====== foods:
		# ======== fid:
		# 	菜品id
		# ======== food_name:
		# 	菜名
		# ======== shop_price:
		# 	销售价格
		# ========== food_status:
		# =========== sold_number:
		# 	这个菜的销量
		# =========== updated_at:
		# 	销量更新时间
		# ==== Response Body Example:
	    # 	[
	    #     {
	    # 		"type_name":"菜品二",
	    # 		"foods":
	    # 		[
	    # 			{
	    # 				"fid":1,
	    # 				"food_name":"翔啊",
	    # 				"shop_price":"1.0",
	    # 				"food_status": {
		#					"sold_number": 0
		#					"updated_at": "2014-10-09T07:18:27.000Z"
		#				}
	   	# 			},
	    # 			{
	    # 				"fid":2,
	    # 				"food_name":"鐧借彍",
	    # 				"shop_price":"1.0",
	    # 				"food_status": {
		#					"sold_number": 0
		#					"updated_at": "2014-10-09T07:18:27.000Z"
		#				}
	    # 			}
	    # 		]
	    #  	 },
	    # 	 {
	    # 		"type_name":"翔类",
	    # 		"foods":
	    # 		[
	    # 			{
	    # 				"fid":3,
	    # 				"food_name":"好菜",
	    # 				"shop_price":"2.0"
	    # 				"food_status": {
		#					"sold_number": 0
		#					"updated_at": "2014-10-09T07:18:27.000Z"
		#				}
	    # 			},
	    # 			{
	    # 				"fid":4,
	    # 				"food_name":"花菜",
	    # 				"shop_price":"1.0"
	    # 				"food_status": {
		#					"sold_number": 0
		#					"updated_at": "2014-10-09T07:18:27.000Z"
		#				}
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
		# ====== is_ticket:
		# 	小票状态，0 是不需要， 1 是需要。
		# ====== is_receipt:
		# 	发票状态，0 是不需要， 1 是需要。
		# ====== is_now:
		# 	立即送状态，0 不是， 1 是。
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
		#
		#
		# == 读取餐馆设置
		# 	读取餐馆设置
	    # ==== GET
	    # 	restaurants/{:restaurant_id}/setting
		# ==== Params
		# ====== {:restaurant_id}:
		# 	餐厅id
		# ====== access_token:
		# 	餐厅管理人员的 access_token
	    # ==== Response Status Code
		# 	200
	    # ==== Response Body
		# ====== board:
		# 	餐馆公告
		# ====== close_hour:
		# 	餐馆关闭时的小时数，默认是 23。假如餐馆关闭时间是 22:02，close_hour 就是 22
		# ====== close_min:
		# 	餐馆关闭时的分钟数，默认是 59。假如餐馆关闭时间是 22:02，close_min 就是 2
		# ====== start_shipping_fee:
		# 	起送价, 默认是 10 元
		# ====== shipping_fee:
		# 	送餐费， 默认是 0 元
		# ====== shipping_time:
		# 	送达时间, 默认 30分钟
		# ====== shipping_phone_number:
		# 	配送电话号码
		# ====== is_sms:
		# 	短信接单，0 表示不启用，1 表示启用，默认为 0
		# ====== is_client:
		# 	客户端接单，0 表示不启用，1 表示启用，默认为 1
		# ====== checked_at:
		# 	商家签到时间，商家当天签到后就开店, 如果没签到就表示没开店
		# ====== 401:
		# 	帐号验证错误，用户名或密码错误
		# ====== 404:
		# 	没有找到相应的订单
		#
		# == 更新餐馆开店状态
		# 	更新餐馆开店状态
	    # ==== PUT
	    # 	restaurants/{:restaurant_id}/is_open
		# ==== Params
		# ====== {:restaurant_id}:
		# 	餐厅id
		# ====== access_token:
		# 	餐厅管理人员的 access_token
	    # ==== Response Status Code
		# 	200
	    # ==== Response Body
		# ====== response_status:
		# 	"restaurant was opened" 或者 "restaurant was closed"
		# ====== 401:
		# 	帐号验证错误，用户名或密码错误
		# ====== 404:
		# 	没有找到相应的订单
		#
		# == 更新餐馆关店时间
		# 	更新餐馆关店时间
	    # ==== PUT
	    # 	restaurants/{:restaurant_id}/close_time
		# ==== Params
		# ====== {:restaurant_id}:
		# 	餐厅id
		# ====== access_token:
		# 	餐厅管理人员的 access_token
		# ====== close_hour:
		# 	餐馆关闭时的小时数，假如餐馆关闭时间是 22:02，close_hour 就是 22
		# ====== close_min:
		# 	餐馆关闭时的小时数，假如餐馆关闭时间是 22:02，close_hour 就是 2
	    # ==== Response Status Code
		# 	200
	    # ==== Response Body
		# ====== response_status:
		# 	"close time was updated"
		# ====== 401:
		# 	帐号验证错误，用户名或密码错误
		# ====== 404:
		# 	没有找到相应的订单
		#
		# == 更新餐馆公告
		# 	更新餐馆公告
	    # ==== PUT
	    # 	restaurants/{:restaurant_id}/board
		# ==== Params
		# ====== {:restaurant_id}:
		# 	餐厅id
		# ====== access_token:
		# 	餐厅管理人员的 access_token
		# ====== board:
		# 	商店公告
	    # ==== Response Status Code
		# 	200
	    # ==== Response Body
		# ====== response_status:
		# 	"board was updated"
		# ====== 401:
		# 	帐号验证错误，用户名或密码错误
		# ====== 404:
		# 	没有找到相应的订单
		#
		# == 更新餐馆起送价
		# 	更新餐馆起送价
	    # ==== PUT
	    # 	restaurants/{:restaurant_id}/start_shipping_fee
		# ==== Params
		# ====== {:restaurant_id}:
		# 	餐厅id
		# ====== access_token:
		# 	餐厅管理人员的 access_token
		# ====== start_shipping_fee:
		# 	起送价
	    # ==== Response Status Code
		# 	200
	    # ==== Response Body
		# ====== response_status:
		# 	"start_shipping_fee was updated"
		# ====== 401:
		# 	帐号验证错误，用户名或密码错误
		# ====== 404:
		# 	没有找到相应的订单
		#
		# == 更新餐馆送餐费
		# 	更新餐馆送餐费
	    # ==== PUT
	    # 	restaurants/{:restaurant_id}/shipping_fee
		# ==== Params
		# ====== {:restaurant_id}:
		# 	餐厅id
		# ====== access_token:
		# 	餐厅管理人员的 access_token
		# ====== shipping_fee:
		# 	送餐费
	    # ==== Response Status Code
		# 	200
	    # ==== Response Body
		# ====== response_status:
		# 	"shipping_fee was updated"
		# ====== 401:
		# 	帐号验证错误，用户名或密码错误
		# ====== 404:
		# 	没有找到相应的订单
		#
		# == 更新餐馆配送时间
		# 	更新餐馆配送时间
	    # ==== PUT
	    # 	restaurants/{:restaurant_id}/shipping_time
		# ==== Params
		# ====== {:restaurant_id}:
		# 	餐厅id
		# ====== access_token:
		# 	餐厅管理人员的 access_token
		# ====== shipping_time:
		# 	送餐时间
	    # ==== Response Status Code
		# 	200
	    # ==== Response Body
		# ====== response_status:
		# 	"shipping_time was updated"
		# ====== 401:
		# 	帐号验证错误，用户名或密码错误
		# ====== 404:
		# 	没有找到相应的订单
		#
		# == 更新餐馆送餐电话
		# 	更新餐馆送餐电话
	    # ==== PUT
	    # 	restaurants/{:restaurant_id}/shipping_phone_number
		# ==== Params
		# ====== {:restaurant_id}:
		# 	餐厅id
		# ====== access_token:
		# 	餐厅管理人员的 access_token
		# ====== shipping_phone_number:
		# 	送餐电话
	    # ==== Response Status Code
		# 	200
	    # ==== Response Body
		# ====== response_status:
		# 	"phone_number was updated"
		# ====== 401:
		# 	帐号验证错误，用户名或密码错误
		# ====== 404:
		# 	没有找到相应的订单
		#
		# == 更新餐馆短信接单状态
		# 	更新餐馆短信接单状态
	    # ==== PUT
	    # 	restaurants/{:restaurant_id}/is_sms
		# ==== Params
		# ====== {:restaurant_id}:
		# 	餐厅id
		# ====== access_token:
		# 	餐厅管理人员的 access_token
	    # ==== Response Status Code
		# 	200
	    # ==== Response Body
		# ====== response_status:
		# 	"sms push service is active"  或者 "sms push service is inactive"
		# ====== 401:
		# 	帐号验证错误，用户名或密码错误
		# ====== 404:
		# 	没有找到相应的订单
		#
		# == 更新餐馆客户端接单状态
		# 	更新餐馆客户端接单状态
	    # ==== PUT
	    # 	restaurants/{:restaurant_id}/is_client
		# ==== Params
		# ====== {:restaurant_id}:
		# 	餐厅id
		# ====== access_token:
		# 	餐厅管理人员的 access_token
	    # ==== Response Status Code
		# 	200
	    # ==== Response Body
		# ====== response_status:
		# 	"client push service is active"  或者 "client push service is inactive"
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
						'password' => Digest::MD5.hexdigest(Digest::MD5.hexdigest(supervisor_password))
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
			        RestaurantStatus.create(:restaurant_id => restaurant.id, :shipping_phone_number => params[:phone_number], :checked_at => (Time.now-1.day))
			    rescue Exception => e
			    	supervisor.delete
			    	restaurant.delete
					restaurant_linsece.delete
					restaurant_address.delete
					error!("Data is invaild", 501) 
			    end
				present:'response_status', 'successed to create a restaurant'
			end

			#根据你的位置读取餐馆列表
			desc "Get restaurant with your location and orders"
			params do
				requires :longitude, type: String
				requires :latitude, type: String
				optional :order_type, type: Integer, default: 0, values: [0, 1, 2, 3]
				optional :restaurant_type, type: Integer, default: 0, values: [0, 1, 2, 3, 4, 5, 6]
				optional :page, type: Integer, default: 0
				optional :count, type: Integer, default: 10
			end
			get do
				error!("bad boy!", 401) if params[:page] < 0 || params[:count] < 0
				restaurants = Restaurant.which_restaurant_type(params[:restaurant_type])
										.near_by(params[:longitude], params[:latitude])
										.opened.order_by(params["order_type"], params[:longitude], params[:latitude])
										.page_with(params[:page], params[:count])
				present restaurants, with: APIEntities::Restaurant
			end

			#根据 餐馆id 读取餐馆
			desc "Get restaurant profile"
			get ":restaurant_id" do
				food_types = Restaurant.find_by(:id => params[:restaurant_id])
				present food_types, with: APIEntities::RestaurantProfile
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

			#读取餐馆设置
			get ":restaurant_id/setting" do
				authenticate_supervisor!
				error!("supervisor is invaild", 401) if current_supervisor.restaurant_id.to_i != params[:restaurant_id].to_i 
				restaurant_status = RestaurantStatus.find_by(:restaurant_id => params[:restaurant_id])
				present restaurant_status, with: APIEntities::RestaurantStatus
			end

			#更新餐馆开店状态
			put ":restaurant_id/is_open" do
				authenticate_supervisor!
				error!("supervisor is invaild", 401) if current_supervisor.restaurant_id.to_i != params[:restaurant_id].to_i 
				restaurant_status = RestaurantStatus.find_by(:restaurant_id => params[:restaurant_id])
				error!("not found", 404) if restaurant_status.nil?
				time_now = Time.now
				if restaurant_status.checked_at.to_date == time_now.to_date
					restaurant_status.checked_at = time_now - 1.day
					response_body = 'restaurant was closed'
				else
					restaurant_status.checked_at = time_now
					response_body = 'restaurant was opened'
				end
				restaurant_status.save
				present:'response_status', response_body
			end

			#更新餐馆关店时间
			put ":restaurant_id/close_time" do
				authenticate_supervisor!
				error!("params is invalid", 401) if params[:close_hour].nil? || params[:close_min].nil?
				error!("supervisor is invalid", 401) if current_supervisor.restaurant_id.to_i != params[:restaurant_id].to_i 
				restaurant_status = RestaurantStatus.find_by(:restaurant_id => params[:restaurant_id])
				error!("not found", 404) if restaurant_status.nil?
				restaurant_status.close_hour = params[:close_hour]
				restaurant_status.close_min = params[:close_min]
				restaurant_status.save
				present:'response_status', 'close time was updated'
			end

			#店铺公告
			put ":restaurant_id/board" do
				authenticate_supervisor!
				error!("params is invalid", 401) if params[:board].nil?
				error!("supervisor is invaild", 401) if current_supervisor.restaurant_id.to_i != params[:restaurant_id].to_i 
				restaurant_status = RestaurantStatus.find_by(:restaurant_id => params[:restaurant_id])
				error!("not found", 404) if restaurant_status.nil?
				restaurant_status.board = params[:board]
				restaurant_status.save
				present:'response_status', 'board was updated'
			end

			#店铺起送价
			put ":restaurant_id/start_shipping_fee" do
				authenticate_supervisor!
				error!("params is invalid", 401) if params[:start_shipping_fee].nil?
				error!("supervisor is invaild", 401) if current_supervisor.restaurant_id.to_i != params[:restaurant_id].to_i 
				restaurant_status = RestaurantStatus.find_by(:restaurant_id => params[:restaurant_id])
				error!("not found", 404) if restaurant_status.nil?
				restaurant_status.start_shipping_fee = params[:start_shipping_fee]
				restaurant_status.save
				present:'response_status', 'start_shipping_fee was updated'
			end

			#店铺送餐费
			put ":restaurant_id/shipping_fee" do
				authenticate_supervisor!
				error!("params is invalid", 401) if params[:shipping_fee].nil?
				error!("supervisor is invaild", 401) if current_supervisor.restaurant_id.to_i != params[:restaurant_id].to_i 
				restaurant_status = RestaurantStatus.find_by(:restaurant_id => params[:restaurant_id])
				error!("not found", 404) if restaurant_status.nil?
				restaurant_status.shipping_fee = params[:shipping_fee]
				restaurant_status.save
				present:'response_status', 'shipping_fee was updated'
			end

			#店铺送餐时间
			put ":restaurant_id/shipping_time" do
				authenticate_supervisor!
				error!("params is invalid", 401) if params[:shipping_time].nil?
				error!("supervisor is invaild", 401) if current_supervisor.restaurant_id.to_i != params[:restaurant_id].to_i 
				restaurant_status = RestaurantStatus.find_by(:restaurant_id => params[:restaurant_id])
				error!("not found", 404) if restaurant_status.nil?
				restaurant_status.shipping_time = params[:shipping_time]
				restaurant_status.save
				present:'response_status', 'shipping_time was updated'
			end


			#店铺送餐电话
			put ":restaurant_id/shipping_phone_number" do
				authenticate_supervisor!
				error!("params is invalid", 401) if params[:shipping_phone_number].nil?
				error!("supervisor is invaild", 401) if current_supervisor.restaurant_id.to_i != params[:restaurant_id].to_i 
				restaurant_status = RestaurantStatus.find_by(:restaurant_id => params[:restaurant_id])
				error!("not found", 404) if restaurant_status.nil?
				restaurant_status.shipping_phone_number = params[:shipping_phone_number]
				restaurant_status.save
				present:'response_status', 'phone_number was updated'
			end



			#店铺短信接收
			put ":restaurant_id/is_sms" do
				authenticate_supervisor!
				error!("supervisor is invaild", 401) if current_supervisor.restaurant_id.to_i != params[:restaurant_id].to_i 
				restaurant_status = RestaurantStatus.find_by(:restaurant_id => params[:restaurant_id])
				error!("not found", 404) if restaurant_status.nil?
				restaurant_status.is_sms = 1 - restaurant_status.is_sms.to_i
				restaurant_status.save
				if restaurant_status.is_sms == 1
					response_body = 'sms push service is active'
				else
					response_body = 'sms push service is inactive'
				end
				present:'response_status', response_body
			end

			#店铺客户端接收
			put ":restaurant_id/is_client" do
				authenticate_supervisor!
				error!("supervisor is invaild", 401) if current_supervisor.restaurant_id.to_i != params[:restaurant_id].to_i 
				restaurant_status = RestaurantStatus.find_by(:restaurant_id => params[:restaurant_id])
				error!("not found", 404) if restaurant_status.nil?
				restaurant_status.is_client = 1 - restaurant_status.is_client.to_i
				restaurant_status.save
				if restaurant_status.is_client == 1
					response_body = 'client push service is active'
				else
					response_body = 'client push service is inactive'
				end
				present:'response_status', response_body
			end
		end
	end
end