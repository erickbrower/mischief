require File.expand_path '../config/boot.rb', __FILE__

{
  '/'          => Controllers::ApplicationController,
  '/api/auth'  => Controllers::AuthController,
  '/api/users' => Controllers::UsersController

}.each_pair do |route, app|
  map(route) { run app }
end
