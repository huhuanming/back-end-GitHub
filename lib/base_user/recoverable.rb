module BaseUser 
	def reset_password!(new_password)
		self.password = new_password
        self.password_confirmation = new_password_confirmation
		
		clear_reset_password_token
        save
	 end

    def send_reset_password_instructions
        self.reset_password_token   = SecureRandom.urlsafe_base64
        self.reset_password_sent_at = Time.now.utc
        self.save

        send_sms_notification(self)
    end

    def reset_password_period_valid?
        Time.new > self.reset_password_sent_at + 10.minutes
    end

	module Recoverable
  		def reset_password_by_token(reset_password_token, new_password)
  			the_class = self.class.find_by(:reset_password_token => reset_password_token)
  			return false if the_class.nil? || the_class.reset_password_period_valid?

  			self.reset_password!(new_password)
  		end
	end

	protected
        def clear_reset_password_token
          self.reset_password_token = nil
          self.reset_password_sent_at = nil
        end

	    def send_sms_notification(the_class)

	    end
end