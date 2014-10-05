module BaseUser

  def authenticate!(password)

    # return false if !self.locked_at.nil? && self.locked_at.to_date == Time.now.to_date

    # if self.failed_attempts > 5
    #   self.locked_at = Time.now
    #   return false 
    # end

    if self.password == password
      self.failed_attempts = 0
      return true
    else
      self.failed_attempts ||= 0
      self.failed_attempts += 1
      self.save
      return false
    end
  end

  def generate_access_token
    class_name = "#{self.class.name}Token"
    method_name = "#{self.class.name.downcase}_id"
    the_class = class_name.constantize

    the_token = the_class.find_or_initialize_by(method_name=>self.id)
    the_token.token = self.generate_token
    the_token.key = self.generate_key
    return the_token if the_token.save
  end

  def generate_token
    return SecureRandom.uuid
  end

  def generate_key
    return SecureRandom.urlsafe_base64
  end

  module Authenticatable
      def login(request)
        phone_number = request.params[:username]
        base_user = self.find_by(:phone_number => phone_number)
        if base_user && base_user.authenticate!(request.params[:password])
          base_user.update_tracked_fields!(request)
          return base_user
        else
          return nil
        end
      end

      def login_by_oauth
      end
  end

end