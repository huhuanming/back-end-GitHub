namespace :deploy do

	  desc 'build this app'
	  task(:build =>[:environment]) do
	  		require 'fileutils'
	  		FileUtils.rm_r '../back-end/.ebextensions'
			FileUtils.copy_entry('.ebextensions', '../back-end/.ebextensions')

	  		FileUtils.rm_r '../back-end/.elasticbeanstalk'
			FileUtils.copy_entry('.elasticbeanstalk', '../back-end/.elasticbeanstalk')

	  		FileUtils.rm_r '../back-end/app'
			FileUtils.copy_entry('app', '../back-end/app')

	  		FileUtils.rm_r '../back-end/config'
			FileUtils.copy_entry('config', '../back-end/config')

	  		FileUtils.rm_r '../back-end/core'
			FileUtils.copy_entry('core', '../back-end/core')

	  		FileUtils.rm_r '../back-end/doc'
			FileUtils.copy_entry('doc', '../back-end/doc')

	  		FileUtils.rm_r '../back-end/lib'
			FileUtils.copy_entry('lib', '../back-end/lib')

	  		FileUtils.rm_r '../back-end/log'
			FileUtils.copy_entry('log', '../back-end/log')

	  		FileUtils.rm_r '../back-end/spec'
			FileUtils.copy_entry('spec', '../back-end/spec')

	  		FileUtils.rm_r '../back-end/tasks'
			FileUtils.copy_entry('tasks', '../back-end/tasks')

	  		FileUtils.rm_r '../back-end/tmp'
			FileUtils.copy_entry('tmp', '../back-end/tmp')

	  		FileUtils.rm_r '../back-end/Capfile'
			FileUtils.copy('Capfile', '../back-end/Capfile')

	  		FileUtils.rm_r '../back-end/Gemfile'
			FileUtils.copy('Gemfile', '../back-end/Gemfile')

	  		FileUtils.rm_r '../back-end/Gemfile.lock'
			FileUtils.copy('Gemfile.lock', '../back-end/Gemfile.lock')

	  		FileUtils.rm_r '../back-end/goliath.pid'
			FileUtils.copy('goliath.pid', '../back-end/goliath.pid')

	  		FileUtils.rm_r '../back-end/LICENSE'
			FileUtils.copy('LICENSE', '../back-end/LICENSE')

	  		FileUtils.rm_r '../back-end/server.rb'
			FileUtils.copy('server.rb', '../back-end/server.rb')

	  		FileUtils.rm_r '../back-end/websocket_server.rb'
			FileUtils.copy('websocket_server.rb', '../back-end/websocket_server.rb')

	  		FileUtils.rm_r '../back-end/README.rdoc'
			FileUtils.copy('README.rdoc', '../back-end/README.rdoc')

	  		FileUtils.rm_r '../back-end/README.md'
			FileUtils.copy('README.md', '../back-end/README.md')
	  end

	  desc 'build and deploy this app'
	  task :push, [:commit_message] => :environment do |task, args|
	    	
	  		require 'fileutils'
	  		FileUtils.rm_r '../back-end/.ebextensions'
			FileUtils.copy_entry('.ebextensions', '../back-end/.ebextensions')

	  		FileUtils.rm_r '../back-end/.elasticbeanstalk'
			FileUtils.copy_entry('.elasticbeanstalk', '../back-end/.elasticbeanstalk')

	  		FileUtils.rm_r '../back-end/app'
			FileUtils.copy_entry('app', '../back-end/app')

	  		FileUtils.rm_r '../back-end/config'
			FileUtils.copy_entry('config', '../back-end/config')

	  		FileUtils.rm_r '../back-end/core'
			FileUtils.copy_entry('core', '../back-end/core')

	  		FileUtils.rm_r '../back-end/doc'
			FileUtils.copy_entry('doc', '../back-end/doc')

	  		FileUtils.rm_r '../back-end/lib'
			FileUtils.copy_entry('lib', '../back-end/lib')

	  		FileUtils.rm_r '../back-end/log'
			FileUtils.copy_entry('log', '../back-end/log')

	  		FileUtils.rm_r '../back-end/spec'
			FileUtils.copy_entry('spec', '../back-end/spec')

	  		FileUtils.rm_r '../back-end/tasks'
			FileUtils.copy_entry('tasks', '../back-end/tasks')

	  		FileUtils.rm_r '../back-end/tmp'
			FileUtils.copy_entry('tmp', '../back-end/tmp')

	  		FileUtils.rm_r '../back-end/Capfile'
			FileUtils.copy('Capfile', '../back-end/Capfile')

	  		FileUtils.rm_r '../back-end/Gemfile'
			FileUtils.copy('Gemfile', '../back-end/Gemfile')

	  		FileUtils.rm_r '../back-end/Gemfile.lock'
			FileUtils.copy('Gemfile.lock', '../back-end/Gemfile.lock')

	  		FileUtils.rm_r '../back-end/goliath.pid'
			FileUtils.copy('goliath.pid', '../back-end/goliath.pid')

	  		FileUtils.rm_r '../back-end/LICENSE'
			FileUtils.copy('LICENSE', '../back-end/LICENSE')

	  		FileUtils.rm_r '../back-end/server.rb'
			FileUtils.copy('server.rb', '../back-end/server.rb')

	  		FileUtils.rm_r '../back-end/websocket_server.rb'
			FileUtils.copy('websocket_server.rb', '../back-end/websocket_server.rb')

	  		FileUtils.rm_r '../back-end/README.rdoc'
			FileUtils.copy('README.rdoc', '../back-end/README.rdoc')

	  		FileUtils.rm_r '../back-end/README.md'
			FileUtils.copy('README.md', '../back-end/README.md')

			args.with_defaults(:commit_message => Time.new.to_s)
			commit_message = args.commit_message

	    	system("cd ../back-end; git add -A")
	    	system("cd ../back-end; git commit -m '" << commit_message << "'")
	    	system("cd ../back-end; git aws.push")
	  end
end