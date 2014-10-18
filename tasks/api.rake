namespace :api do
  desc "create a api"
  task :build, [:api_name] => :environment do |task, args|
    require 'fileutils'
    FileUtils.touch 'app/apis/restfuls/v1/' + args.api_name + "_api.rb"
    FileUtils.touch 'app/apis/helpers/' + args.api_name + "_helper.rb"
    FileUtils.touch 'app/apis/entities/' + args.api_name + "_entity.rb"
    FileUtils.touch 'app/models/' + args.api_name + ".rb"
    FileUtils.touch 'spec/apis/' + args.api_name + "_api_spec.rb"
    FileUtils.touch 'spec/factories/' + args.api_name + "s.rb"
    FileUtils.touch 'spec/models/' + args.api_name + "_spec.rb"
  end

  desc "delete a api"
  task :destory, [:api_name] => :environment do |task, args|
    require 'fileutils'
    FileUtils.rm 'app/apis/restfuls/v1/' + args.api_name + "_api.rb"
    FileUtils.rm 'app/apis/helpers/' + args.api_name + "_helper.rb"
    FileUtils.rm 'app/apis/entities/' + args.api_name + "_entity.rb"
    FileUtils.rm 'app/models/' + args.api_name + ".rb"
    FileUtils.rm 'spec/apis/' + args.api_name + "_api_spec.rb"
    FileUtils.rm 'spec/factories/' + args.api_name + "s.rb"
    FileUtils.rm 'spec/models/' + args.api_name + "_spec.rb"

  end
end