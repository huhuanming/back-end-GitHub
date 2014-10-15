class Supervisor < ActiveRecord::Base
	include BaseUser
	has_one :supervisor_token
	has_one :supervisor_push
	belongs_to :restaurant
end