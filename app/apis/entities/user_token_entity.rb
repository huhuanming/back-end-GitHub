module Restfuls
	module APIEntities

    class UserAccessToken < Grape::Entity
          expose :token, as: :token
          expose :key, as: :key
    end
		class UserToken < Grape::Entity
          expose :id, as: :user_id
          expose :nick_name, as: :name
      		expose :last_sign_in_at, as: :last_login_at, format_with: :iso_timestamp
      		expose :user_token, as: :access_token, using: Restfuls::APIEntities::UserAccessToken
      		format_with(:iso_timestamp) { |date| date.iso8601 }
    	end
	end
end