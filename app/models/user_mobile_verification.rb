require 'net/http'

class UserMobileVerification < ActiveRecord::Base

	# Examine phone number and failed attemp 
	def is_valid?
		self.failed_attempts = 0 if self.updated_at.nil? || Time.now.to_i - self.updated_at.to_i > 86400
		return self.failed_attempts > 5
	end

	# check mobile verification code
	def is_verify?(encoded, encoded_sign)
		return false if Time.now.to_i - self.updated_at.to_i > 3000
		key = UserMobileVerification.find_by(:phone_number => self.phone_number).verification_code
		return CGI.escape(Base64.encode64(OpenSSL::HMAC.digest('sha1', key, encoded)).chomp) == encoded_sign
	end

	def send_verification_code
		self.verification_code = rand(1000..9999)
		self.save

		params = Hash.new
		params["apikey"] = APIKEY
		params["mobile"] = self.phone_number
		params["tpl_id"] = 2       
		params["tpl_value"] = URI.escape("#code#=#{self.verification_code}&#company#=零公里外卖")
		# res = Net::HTTP.post_form(URI.parse(VERIFICATIONCODEURI), params)
		EventMachine.run do
	      EventMachine::HttpRequest.new(VERIFICATIONCODEURI).post :body => params
	    end
		#  EventMachine.run do
		#   http = EventMachine::HttpRequest.new('http://www.0km.me:9000/v1/ping').get
		#   http.callback { |chunk| pp chunk.response }
		# end
	end
end