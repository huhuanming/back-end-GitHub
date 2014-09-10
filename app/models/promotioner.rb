class Promotioner < ActiveRecord::Base
	include BaseUser

	has_one :promotioner_token
end