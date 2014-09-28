class User < ActiveRecord::Base
	include BaseUser

	has_one :user_token 
end