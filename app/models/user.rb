class User < ActiveRecord::Base
	include BaseUser
	has_many :oauth_users
	has_one :user_token 
end