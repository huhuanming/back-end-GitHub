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


	  	class StatusWithRestaurantProfile < Grape::Entity
	          expose :start_shipping_fee, as: :start_shipping_fee
	          expose :shipping_time, as: :shipping_time
	          expose :shipping_fee, as: :shipping_fee
	          expose :board, as: :board
	    end

	  	class AddressWithRestaurantProfile < Grape::Entity
	          expose :address, as: :address
	          expose :radius, as: :radius
	    end

	  	class NameTypeWithRestaurantProfile < Grape::Entity
	          expose :type_name, as: :type_name
	    end

	  	class TypeWithRestaurantProfile < Grape::Entity
	          expose :restaurant_type_name, as: :restaurant_type_name, using: Restfuls::APIEntities::NameTypeWithRestaurantProfile
	    end

		class RestaurantProfile < Grape::Entity
            expose :id, as: :rid
      		expose :restaurant_name, as: :name
      		expose :restaurant_avatar, as: :avatar
      		expose :phone_number, as: :phone_number
      		expose :restaurant_address, as: :restaurant_address, using: Restfuls::APIEntities::AddressWithRestaurantProfile
      		expose :restaurant_status, as: :restaurant_status, using: Restfuls::APIEntities::StatusWithRestaurantProfile
      		expose :restaurant_types, as: :restaurant_type, using: Restfuls::APIEntities::TypeWithRestaurantProfile
    	end
	end
end