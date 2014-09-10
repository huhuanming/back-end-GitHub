module Restfuls
	module APIEntities
		 class AccessToken < Grape::Entity
      		expose :token, as: :token
      		expose :key, as: :key
    	end
	end
end