class Supervisor < ActiveRecord::Base
	include BaseUser
	has_one :supervisor_token
	belongs_to :restaurant
end