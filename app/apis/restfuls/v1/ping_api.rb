module Restfuls
	##
	# 与服务器 v1 版接口进行连接，测试服务器是否能正常工作
  class Pingv1 < Grape::API
    format :json
	##
	# = 操作
	# * PingREMOTE_ADDR
	# == Ping
	# 	与服务器进行ping
	# ==== GET
	# 	/ping
	# ==== Return
	# ====== api_version:
	# 	api版本号
	# ====== time:
	# 	当前时间
	# ==== Return Example
	# 	{"ping":"{"api_version":"v1","time":"2014-08-11T19:55:13.370+08:00"}"}
    get '/ping' do
      data = {
      	'api_version' => 'v1',
      	'time' => Time.new,
      	'ip' => request.env.REMOTE_ADDR
      }
      present data
    end
  	

    post '/authenticate_promotioner' do 
         authenticate_promotioner!
         present:ping, Time.new
    end


    get '/authenticate_promotioner' do 
         authenticate_promotioner!
         present:ping, Time.new
    end


  end
end
