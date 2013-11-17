module Initializers
  module Auth

    def self.included(base)
      base.class_eval do

        use Warden::Manager do |config|
          config.scope_defaults :default,
            strategies: [:auth_token, :password],
            action: '/unauthorized'
          config.failure_app = self
        end

        Warden::Manager.serialize_into_session{ |user| user.id }

        Warden::Manager.serialize_from_session{ |id| User.find(id) }

        Warden::Manager.before_failure do |env, opts|
          env['REQUEST_METHOD'] = 'POST'
        end

        Warden::Strategies.add(:auth_token) do
          def valid?
            request.env['AUTH_TOKEN'].is_a? String
          end

          def authenticate!
            token = ::AuthToken.where(value: request.env['AUTH_TOKEN']).first
            access_granted = token && token.active?
            !access_granted ? fail!("Could not log in") : success!(token.user)
          end
        end

        Warden::Strategies.add(:password) do
          def valid?
            params['email'] && params['password']
          end

          def authenticate!
            user = ::User.where(email: params['email']).first
            access_granted = user && user.authenticate(params['password'])
            !access_granted ? fail!('Could not log in!') : success!(user)
          end
        end

      end
    end
  end
end
