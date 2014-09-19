module Restfuls
	module APIEntities
		class RestaurantStatus < Grape::Entity
          expose :open_status, as: :open_status
      		expose :board, as: :board
      		expose :close_hour, as: :close_hour
          expose :close_min, as: :close_min
          expose :close_hour, as: :close_hour
          expose :close_min, as: :close_min
          expose :start_shipping_fee, as: :start_shipping_fee
          expose :shipping_fee, as: :shipping_fee
          expose :shipping_time, as: :shipping_time
          expose :shipping_phone_number, as: :shipping_phone_number
          expose :is_sms, as: :is_sms
          expose :is_client, as: :is_client
    end
	end
end