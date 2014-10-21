require 'em-http-request'
class UserMobileVerification < ActiveRecord::Base
	VERIFICATIONCODEURI = "http://101.227.175.19/api/user_sms/send_tpl_sms"
	# Examine phone number and failed attemp 
	def is_valid?
		return false if self.updated_at.nil?
		duration_time = Time.now.to_i - self.updated_at.to_i
		if duration_time > 86400
			self.failed_attempts = 0
			self.sent_attempts = 0
			self.save
		end

		return self.sent_attempts > 5 || self.failed_attempts > 5
	end

	# check mobile verification code
	def verify?(encryption_code)
		encryption_code_array = encryption_code.split(":")

		return false if encryption_code_array.length != 2

		encoded_sign = encryption_code_array[0]
		encoded = encryption_code_array[1]
		
		duration_time = Time.now.to_i - self.updated_at.to_i

		if duration_time > 1800
			return false
		end

		key = self.verification_code
		if CGI.escape(Base64.encode64(OpenSSL::HMAC.digest('sha1', key, encoded)).chomp) == encoded_sign
			self.failed_attempts = 0
			self.sent_attempts = 0
			self.save
			return true
		else
			self.failed_attempts += 1
			self.save
			return false
		end 
	end

	def not_verify?(encryption_code)
		return !self.verify?(encryption_code)
	end

	def send_verification_code
		if self.updated_at.nil?
		
		else
			duration_time = Time.now.to_i - self.updated_at.to_i
			return false if duration_time < 60
		end

		self.verification_code = rand(100000..999999).to_s
		self.sent_attempts ||= 0
		self.sent_attempts += 1
		self.save

		params = Hash.new
		params["mobile"] = self.phone_number
		params["tpl_value"] = URI.escape("#code#=#{self.verification_code}&#company#=零公里外卖")
		EventMachine.run do
	      EventMachine::HttpRequest.new(VERIFICATIONCODEURI).post :body => params
	    end
	    return true
	end
end