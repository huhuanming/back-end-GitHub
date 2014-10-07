class Restaurant < ActiveRecord::Base
	has_one :restaurant_linsece
	has_one :restaurant_address
	has_one :restaurant_status
	has_many :supervisors

	scope :opened, -> { joins(:restaurant_status).where(" ? <= checked_at and checked_at <= ?", Time.now.at_beginning_of_day, Time.now.at_end_of_day)}
	scope :near_by, ->(longitude, latitude) { joins(:restaurant_address).where("coordinate_x1 <= ? and ? <= coordinate_x2 and coordinate_y1 <= ? and ? <= coordinate_y2", longitude, longitude, latitude, latitude) }
	scope :order_by, ->(order_type, longitude, latitude) {
		case order_type
		when 0
		   joins(:restaurant_address).order("(POW((longitude - #{longitude}),2) + POW((latitude - #{latitude}),2)) ASC") 
		when 1
		   joins(:restaurant_status).order("shipping_time ASC")
		when 2
		   joins(:restaurant_address).order("(POW((longitude - #{longitude}),2) + POW((latitude - #{latitude}),2)) ASC") 
		when 3
		   joins(:restaurant_status).order("shipping_fee ASC")
		end
	}
	scope :which_restaurant_type, ->(restaurant_type){ 
		# joins(:restaurant_status).order("shipping_time ASC") 
	}
	scope :page_with, ->(page, count) { limit(count).offset(page * count) }
end