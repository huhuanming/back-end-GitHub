module Restfuls
	module APIEntities
		class UserAddress < Grape::Entity
      	  expose :shipping_user, as: :shipping_user
      	  expose :shipping_address, as: :shipping_address
          expose :phone_number, as: :phone_number
          expose :is_default, as: :is_default
    	end
	end
end