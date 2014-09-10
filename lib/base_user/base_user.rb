require 'bcrypt'
module BaseUser 
	include BCrypt

  def self.included(receiver)
    receiver.extend Authenticatable
    receiver.extend Trackable
    receiver.extend Lockable
    receiver.extend Registerable
    receiver.extend Recoverable
  end

	def password
    @password ||= Password.new(encrypted_password)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.encrypted_password = @password
  end

end