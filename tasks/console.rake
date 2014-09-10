namespace :console do
	  desc 'Development environment console'
	  task(:d => [:environment]) do
	    	system("ruby server.rb -sv -e development -C")
	  end

	  desc 'Production environment console'
	  task(:p => [:environment]) do
	    	system("ruby server.rb -sv -e production -C")
	  end
end

namespace :c do
	  desc 'Development environment console'
	  task(:d => [:environment]) do
	    	system("ruby server.rb -sv -e development -C")
	  end

	  desc 'Production environment console'
	  task(:p => [:environment]) do
	    	system("ruby server.rb -sv -e production -C")
	  end
end