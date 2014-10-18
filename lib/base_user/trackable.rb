module BaseUser 
  def update_tracked_fields!(request)
      old_current, new_current = self.current_sign_in_at, Time.now.utc
      self.last_sign_in_at     = old_current || new_current
      self.current_sign_in_at  = new_current

      old_current, new_current = self.current_sign_in_ip, request.env.REMOTE_ADDR
      self.last_sign_in_ip     = old_current || new_current
      self.current_sign_in_ip  = new_current

      self.sign_in_count ||= 0
      self.sign_in_count += 1
      save(validate: false) or raise "Devise trackable could not save #{inspect}." \
      "Please make sure a model using trackable can be saved at sign in."
  end
  
  module Trackable

  end
end