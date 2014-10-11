class OrderSign < ActiveRecord::Base
	has_one :order	
	has_many :order_foods
	belongs_to :restaurant
end