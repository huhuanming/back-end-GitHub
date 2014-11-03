class Restaurant < ActiveRecord::Base

	ORDERBOOKINGURI = "http://54.64.190.26/api/pushes/restaurant/overbooking"

	has_one :restaurant_linsece
	has_one :restaurant_address
	has_one :restaurant_status
	has_many :restaurant_comments
	has_many :supervisors
	has_many :restaurant_types
	has_many :order_sign

	scope :opened, -> { joins(:restaurant_status).where(" ? <= checked_at and checked_at <= ?", "2008-11-03 09:58:22 +0800", "2015-11-03 09:58:22 +0800")}#Time.now.at_beginning_of_day, Time.now.at_end_of_day)}
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
		if restaurant_type > 0
			joins(:restaurant_types).where("restaurant_type_name_id = ?", restaurant_type)
		end
	}
	scope :page_with, ->(page, count) { limit(count).offset(page * count) }

	def push_orderbooking_inform
		params = Hash.new
		params["badge"] = "1"
		supervisor_push = Restaurant.supervisors.first.supervisor_push
		return if supervisor_push.nil?
		params["push_id"] = supervisor_push.push_id
		uri = URI.parse(ORDERBOOKINGURI)
		res = Net::HTTP.post_form(uri, params)   
		puts res.body
	end
end