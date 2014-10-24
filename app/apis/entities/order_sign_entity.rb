module Restfuls
	module APIEntities

    class RestaurantWithOrderSign < Grape::Entity
        expose :restaurant_name, as: :restaurant_name
        expose :phone_number, as: :phone_number
    end

    class OrderWithOrderSign < Grape::Entity
        expose :shipping_user, as: :shipping_user
        expose :shipping_address, as: :shipping_address
        expose :phone_number, as: :phone_number
        expose :total_price, as: :total_price
        expose :actual_total_price, as: :actual_total_price
        expose :order_type, as: :order_type
    end

		class OrderSign < Grape::Entity
          expose :id, as: :oid
          expose :sign, as: :order_sign
          expose :created_at, as: :created_at
      		expose :updated_at, as: :updated_at
          expose :restaurant, as: :restaurant, using: Restfuls::APIEntities::RestaurantWithOrderSign
          expose :order, as: :order_info, using: Restfuls::APIEntities::OrderWithOrderSign
    end
	end
end