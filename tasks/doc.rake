namespace :doc do
	  desc 'build doc'
	  task(:build => [:environment]) do
	    	system("rdoc app/apis/restfuls/v1/")
	    	require 'fileutils'
			FileUtils.cp('tasks/lib/darkfish.js', 'doc/js/darkfish.js')
			FileUtils.copy_entry('doc','/Users/hu/Project/promotioner_ios/0km_Popularize/doc')
			FileUtils.copy_entry('doc','/Users/hu/WorkSpace/promotioner_android/doc')
			FileUtils.copy_entry('doc','/Users/hu/WorkSpace/Merchants/doc')
	  end
end