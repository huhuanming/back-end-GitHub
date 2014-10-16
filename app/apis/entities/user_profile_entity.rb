module Restfuls
	module APIEntities

    class UserProfileOauth < Grape::Entity
          expose :oauth_type, as: :oauth_type
    end
    class UserProfile < Grape::Entity
          expose :nick_name, as: :token
          expose :avatar, as: :avatar
          expose :phone_number, as: :phone_number
          expose :oauth, as: :access_token, using: Restfuls::APIEntities::UserProfileOauth
    end

	end
end