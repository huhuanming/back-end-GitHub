module Restfuls
	module APIEntities
		class Order < Grape::Entity
      		expose :id, as: :order_id
      		expose :ship_type, as: :ship_type
      		expose :order_type, as: :order_type
      		expose :phone_number, as: :phone_number
      		expose :shipping_address, as: :shipping_address
      		expose :total_price, as: :total_price
      		expose :actual_total_price, as: :actual_total_price
      		expose :created_at, as: :created_at
      		expose :updated_at, as: :updated_at
      		expose :shipping_at, as: :shipping_at
    	end
	end
end