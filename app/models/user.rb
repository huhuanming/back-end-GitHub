class User < ActiveRecord::Base
	include BaseUser
	has_many :oauth_users
	has_many :order_signs
	has_many :user_addresses
	has_one :user_token 
end