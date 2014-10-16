module Restfuls
	module APIEntities

            class FoodWithOrderFood < Grape::Entity
                  expose :food_name, as: :food_name
                  expose :shop_price, as: :shop_price
            end
		class OrderFood < Grape::Entity

          expose :count, as: :count
      		expose :total_price, as: :total_price
      		expose :actual_total_price, as: :actual_total_price
          expose :food, as: :food, using: Restfuls::APIEntities::FoodWithOrderFood
    end
	end
end