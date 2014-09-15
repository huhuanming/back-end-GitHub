class Order < ActiveRecord::Base
	# has_many :foods
	belongs_to :restaurant
end