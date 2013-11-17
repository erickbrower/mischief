require 'sinatra/base'

module Sinatra
  module Authenticator

    # Includes an authentication hook for all actions in the current Sinatra app
    # that ensures a valid, logged in {User} is making the request
    def authenticate!
      before do
        env['warden'].authenticate!
      end
    end
  end

  # Registers {#authenticate!} as a global Sinatra DSL method
  register Authenticator
end
