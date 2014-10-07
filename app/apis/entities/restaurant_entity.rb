module Restfuls
	module APIEntities
	  	class TheRestaurantStatus < Grape::Entity
	          expose :start_shipping_fee, as: :start_shipping_fee
	          expose :shipping_time, as: :shipping_time
	    end

		class Restaurant < Grape::Entity
            expose :id, as: :rid
      		expose :restaurant_name, as: :name
      		expose :restaurant_avatar, as: :avatar
      		expose :restaurant_status, as: :status, using: Restfuls::APIEntities::TheRestaurantStatus
    	end
	end
end