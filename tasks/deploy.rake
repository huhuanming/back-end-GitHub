namespace :deploy do

	  desc 'build this app'
	  task(:build =>[:environment]) do
	  		require 'fileutils'

			FileUtils.copy_entry('app', '../back-end-souhu/app/app')

			FileUtils.copy_entry('config', '../back-end-souhu/app/config')

			FileUtils.copy_entry('core', '../back-end-souhu/app/core')

			FileUtils.copy_entry('lib', '../back-end-souhu/app/lib')

			FileUtils.copy_entry('tasks', '../back-end-souhu/app/tasks')

			FileUtils.copy('Capfile', '../back-end-souhu/app/Capfile')

			FileUtils.copy('server.rb', '../back-end-souhu/app/server.rb')

			FileUtils.copy('websocket_server.rb', '../back-end-souhu/app/websocket_server.rb')
	  end

	  desc 'build and deploy this app'
	  task :push, [:commit_message] => :environment do |task, args|
	    	
	  		require 'fileutils'

	  		FileUtils.rm_r '../back-end-souhu/app/app'
			FileUtils.copy_entry('app', '../back-end-souhu/app/app')

	  		FileUtils.rm_r '../back-end-souhu/app/config'
			FileUtils.copy_entry('config', '../back-end-souhu/app/config')

	  		FileUtils.rm_r '../back-end-souhu/app/core'
			FileUtils.copy_entry('core', '../back-end-souhu/app/core')

	  		FileUtils.rm_r '../back-end-souhu/app/lib'
			FileUtils.copy_entry('lib', '../back-end-souhu/app/lib')

	  		FileUtils.rm_r '../back-end-souhu/app/Capfile'
			FileUtils.copy('Capfile', '../back-end-souhu/app/Capfile')

	  		FileUtils.rm_r '../back-end-souhu/app/server.rb'
			FileUtils.copy('server.rb', '../back-end-souhu/app/server.rb')

	  		FileUtils.rm_r '../back-end-souhu/app/websocket_server.rb'
			FileUtils.copy('websocket_server.rb', '../back-end-souhu/app/websocket_server.rb')

			args.with_defaults(:commit_message => Time.new.to_s)
			commit_message = args.commit_message

	    	system("cd ../back-end-souhu; git add -A")
	    	system("cd ../back-end-souhu; git commit -m '" << commit_message << "'")
	    	system("cd ../back-end-souhu; git push")
	  end

end