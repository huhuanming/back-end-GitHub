module Application
  class Api < Grape::API
    format :json
    # 拦截错误信息，显示简单错误信息，不显示调用堆栈
    #rescue_from :all do |e|
    #  Rack::Response.new([e.message], 500, { "Content-type" => "application/json" }).finish
    #end
    helpers ApiHelper
    mount Restfuls::Pingv1 => '/v1'
    mount Restfuls::Promotionerv1 => '/v1'
    mount Restfuls::Restaurantv1 => '/v1'
    mount Restfuls::RestaurantTypev1 => '/v1'
    mount Restfuls::Supervisorv1 => '/v1'
    mount Restfuls::Menuv1 => '/v1'
    mount Restfuls::Userv1 => '/v1'
  end
end
