module Restfuls
	module APIEntities

		class FoodStatusWithFoodWithMenu < Grape::Entity
			expose :sold_number, as: :sold_number
			expose :updated_at, as: :updated_at
		end

		class FoodWithMenu < Grape::Entity
			expose :id, as: :fid
      		expose :food_name, as: :food_name
      		expose :food_status, as: :food_status, using: Restfuls::APIEntities::FoodStatusWithFoodWithMenu
      		expose :shop_price, as: :shop_price
		end

		class Menu < Grape::Entity
      		expose :type_name, as: :type_name
      		expose :foods, as: :foods, using: Restfuls::APIEntities::FoodWithMenu
    	end

	end
end