require 'securerandom'

module Factory
  module Users
    def self.valid_attrs
      {
        email: "test#{SecureRandom.hex(20)}@test.com",
        password: "12345678",
        password_confirmation: "12345678"
      }
    end

    def self.make
      User.new valid_attrs
    end

    def self.make!
      User.create valid_attrs
    end

    def self.make_with_posts(num=5)
      user = make
      num.times do |n|
        user.posts << Factory::Posts.make 
      end
      user
    end

    def self.make_with_hourly_auth_token!
      user = make
      user.auth_tokens << Factory::AuthTokens.make_hourly
      user.save
      user
    end
  end

  module AuthTokens
    def self.valid_attrs
      {}
    end

    def self.make
      AuthToken.new valid_attrs
    end

    def self.make!
      AuthToken.create! valid_attrs
    end

    def self.make_hourly
      HourlyAuthToken.new valid_attrs
    end
  end

end
