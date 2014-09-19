class Order < ActiveRecord::Base
	has_many :order_foods
	belongs_to :restaurant
end