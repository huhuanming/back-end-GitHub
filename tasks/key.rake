namespace :key do
	  desc 'generate access token'
	  task :build, [:token, :key, :ttl, :device] => :environment do |task, args|
	  	args.with_defaults(:ttl => 300)
	  	args.with_defaults(:device => 1)
	  	ttl = args.ttl
	  	device = args.device
	  	data = Hash.new
	  	deadline = Time.now.to_i + ttl.to_i
	  	data["deadline"] = deadline
	  	data["device"] = device
	  	encoded = CGI::escape(data.to_json)
	  	encoded_sign = CGI.escape(Base64.encode64(OpenSSL::HMAC.digest('sha1', args.key, encoded)).chomp)
	  	access_token = ""+ args.token + ":" + encoded_sign + ":" + encoded
	  	puts access_token
	  end
end