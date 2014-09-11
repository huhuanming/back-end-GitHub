module Restfuls
	module APIEntities

		class FoodWithMenu < Grape::Entity
      		expose :food_name, as: :food_name
      		expose :shop_price, as: :shop_price
		end
		class Menu < Grape::Entity
      		expose :type_name, as: :type_name
      		expose :foods, as: :foods, using: Restfuls::APIEntities::FoodWithMenu
    	end
	end
end