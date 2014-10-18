module Restfuls
	module APIEntities

    class UserProfileOauth < Grape::Entity
          expose :oauth_type, as: :oauth_type
    end
    class UserProfile < Grape::Entity
          expose :nick_name, as: :token
          expose :avatar, as: :avatar
          expose :phone_number, as: :phone_number
          expose :oauth_users, as: :oauth, using: Restfuls::APIEntities::UserProfileOauth
    end

	end
end