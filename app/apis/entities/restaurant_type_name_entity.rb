module Restfuls
	module APIEntities
		class RestaurantTypeName < Grape::Entity
      	  expose :id, as: :restaurant_type
          expose :type_name, as: :restaurant_type_name
    	end
	end
end