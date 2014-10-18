class RestaurantComment < ActiveRecord::Base
	belongs_to :restaurant

	scope :order_by, ->(order_type) {
		case order_type
		when 0
		   order("id DESC")
		when 1
		  order("point DESC")
		end
	}
end