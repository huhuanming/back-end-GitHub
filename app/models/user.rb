class User < ActiveRecord::Base
	include BaseUser
	has_many :oauth_users
	has_many :order_signs
	has_many :user_addresses
	has_many :restaurant_comments
	has_one :user_token
	has_one :user_push 
end