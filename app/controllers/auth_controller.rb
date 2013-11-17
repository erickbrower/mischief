module Controllers
  class AuthController < ApplicationController
    # @!method post_login
    # @overload post '/login'
    # Logs a user in and provides an {AuthToken} if successful
    # @return [HourlyAuthToken] A JSON-encoded {HourlyAuthToken} 
    post '/login' do
      env['warden'].authenticate!
      token = HourlyAuthToken.new
      current_user.auth_tokens << token
      json token
    end
  end
end
