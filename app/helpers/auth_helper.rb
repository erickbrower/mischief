module Helpers
  module AuthHelper

    def self.included(base)

      # Gets the currently authenticated {User} from the env, if it exists
      # @return [User] The current logged in user
      def current_user
        env['warden'].user
      end

    end

  end
end
