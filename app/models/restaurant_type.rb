class RestaurantType < ActiveRecord::Base
	belongs_to :restaurant
	belongs_to :restaurant_type_name
end