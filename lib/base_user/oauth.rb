module BaseUser 
  module Oauth
      def login_by_oauth(request)
      	oauth_token = request.params["oauth_token"]
      	case request.params["oauth_type"].to_i
      	when 0

      	when 1

      	else
      			
      	end
      end
  end
end