class Restaurant < ActiveRecord::Base
	has_one :restaurant_linsece
	has_one :restaurant_address
	has_many :supervisors
end