module Restfuls
	module APIEntities
		class Order < Grape::Entity
      		expose :id, as: :order_id
      		expose :ship_type, as: :ship_type
      		expose :order_type, as: :order_type
                  expose :is_ticket, as: :is_ticket
                  expose :is_receipt, as: :is_receipt
                  expose :is_now, as: :is_now
      		expose :phone_number, as: :phone_number
                  expose :food_count, as: :food_count
                  expose :remark, as: :order_remark
                  expose :shipping_user, as: :shipping_user
                  expose :shipping_address, as: :shipping_address
      		expose :total_price, as: :total_price
      		expose :actual_total_price, as: :actual_total_price
      		expose :created_at, as: :created_at, format_with: :iso_timestamp
      		expose :updated_at, as: :updated_at, format_with: :iso_timestamp
      		expose :shipping_at, as: :shipping_at, format_with: :iso_timestamp
                  format_with(:iso_timestamp) { |date| date.iso8601 }
    	       end
	end
end