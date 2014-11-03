module Restfuls
	module APIEntities

    class RestaurantWithOrderSignDetail < Grape::Entity
        expose :id, as: :rid
        expose :restaurant_name, as: :restaurant_name
        expose :phone_number, as: :phone_number
    end

    class OrderWithOrderSignDetail < Grape::Entity
        expose :shipping_user, as: :shipping_user
        expose :shipping_address, as: :shipping_address
        expose :shipping_at, as: :shipping_at
        expose :shipping_fee, as: :shipping_fee
        expose :phone_number, as: :phone_number
        expose :total_price, as: :total_price
        expose :actual_total_price, as: :actual_total_price
        expose :order_type, as: :order_type
        expose :is_ticket, as: :is_ticket
        expose :is_receipt, as: :is_receipt
        expose :is_now, as: :is_now
    end

    class OrderFoodWithOrderSignDetail < Grape::Entity
        expose :food_name, as: :food_name
        expose :count, as: :count
    end

		class OrderSignDetail < Grape::Entity
          expose :id, as: :oid
          expose :sign, as: :order_sign
          expose :created_at, as: :created_at, format_with: :iso_timestamp
      		expose :updated_at, as: :updated_at, format_with: :iso_timestamp
          expose :order_foods, as: :order_foods, using: Restfuls::APIEntities::OrderFoodWithOrderSignDetail
          expose :restaurant, as: :restaurant, using: Restfuls::APIEntities::RestaurantWithOrderSignDetail
          expose :order, as: :order_info, using: Restfuls::APIEntities::OrderWithOrderSignDetail
          format_with(:iso_timestamp) { |date| date.iso8601 }
    end
	end
end