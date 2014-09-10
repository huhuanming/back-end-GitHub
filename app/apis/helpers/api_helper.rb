module ApiHelper
  def authenticate_promotioner!
      access_token = params[:access_token]
      
      begin
        token_array = access_token.split(":")
      rescue Exception => e
        error!("AccessToken is invalid", 401)
      end


      token = token_array[0]
      encode_signed = token_array[1]
      encoded = token_array[2]
      error!("AccessToken is invalid", 401) if token_array.length != 3

      data = CGI::unescape(encoded)

      begin
        data = JSON.parse(data)
      rescue Exception => e
        error!("AccessToken is invalid", 401)
      end

      begin
        deadline = data["deadline"]
      rescue Exception => e
        error!("AccessToken is invalid", 401)
      end

      error!("AccessToken is invalid, deadline is timeout", 401) if Time.new.to_i >= deadline

      promotioner_token = PromotionerToken.find_by(:token => token)

      error!("AccessToken is not found", 404) if promotioner_token.nil?

      error!("AccessToken is invalid", 401) if encode_signed != encoded_sign(promotioner_token.key, encoded)
  end

  def authenticate_supervisor!
      access_token = params[:access_token]
      
      begin
        token_array = access_token.split(":")
      rescue Exception => e
        error!("AccessToken is invalid", 401)
      end


      token = token_array[0]
      encode_signed = token_array[1]
      encoded = token_array[2]
      error!("AccessToken is invalid", 401) if token_array.length != 3

      data = CGI::unescape(encoded)

      begin
        data = JSON.parse(data)
      rescue Exception => e
        error!("AccessToken is invalid", 401)
      end

      begin
        deadline = data["deadline"]
      rescue Exception => e
        error!("AccessToken is invalid", 401)
      end

      error!("AccessToken is invalid, deadline is timeout", 401) if Time.new.to_i >= deadline

      supervisor_token = SupervisorToken.find_by(:token => token)

      error!("AccessToken is not found", 404) if supervisor_token.nil?

      error!("AccessToken is invalid", 401) if encode_signed != encoded_sign(supervisor_token.key, encoded)
  end

  def current_promotioner
      access_token = params[:access_token]
      token_array = access_token.split(":")

      token = token_array[0]
      promotioner = PromotionerToken.find_by(:token => token).promotioner

      error!("Promotioner is not exsit", 404) if promotioner.nil?

      return promotioner
  end

  def current_supervisor
      access_token = params[:access_token]
      token_array = access_token.split(":")

      token = token_array[0]
      supervisor = SupervisorToken.find_by(:token => token).supervisor

      error!("Promotioner is not exsit", 404) if supervisor.nil?

      return supervisor
  end

  def encoded_sign(key, encoded)
      encoded_sign = CGI.escape(Base64.encode64(OpenSSL::HMAC.digest('sha1', key, encoded)).chomp)
      return encoded_sign
  end


end
