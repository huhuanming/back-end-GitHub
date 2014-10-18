namespace :server do
	  desc 'Start server with development environment'
	  task(:d => [:environment]) do
	    	system("ruby server.rb -sv -e development -l log/development.log")
	  end

	  desc 'Start server with production environment'
	  task(:p => [:environment]) do
	    	system("ruby server.rb -sv -e production -l log/production.log -d")
	  end
end

namespace :s do
	  desc 'Start server with development environment'
	  task(:d => [:environment]) do
	    	system("ruby server.rb -sv -e development -l log/development.log")
	  end

	  desc 'Start server with production environment'
	  task(:p => [:environment]) do
	    	system("ruby server.rb -sv -e production -l log/production.log -d")
	  end
end