require File.join(File.dirname(__FILE__), '', 'access_token_entity')
module Restfuls
	module APIEntities
		class Supervisor < Grape::Entity
      		expose :sign_in_count, as: :login_count 
      		expose :last_sign_in_at, as: :last_login_at, format_with: :iso_timestamp
      		expose :supervisor_token, as: :access_token, using: Restfuls::APIEntities::AccessToken
      		format_with(:iso_timestamp) { |date| date.iso8601 }
    	end
	end
end