namespace :doc do
	  desc 'build doc'
	  task(:build => [:environment]) do
	    	system("rdoc app/apis/restfuls/v1/")
	    	require 'fileutils'
			FileUtils.cp('tasks/lib/darkfish.js', 'doc/js/darkfish.js')
			FileUtils.copy_entry('doc','../api_doc')
	  end
end