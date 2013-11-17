require File.expand_path '../../test_helper.rb', __FILE__

class AuthControllerTest < MiniTest::Unit::TestCase

  include Rack::Test::Methods

  def app
    Controllers::AuthController
  end

  def test_auth_login
    user = Factory::Users.make!
    post '/login.json', {
      email: user.email,
      password: user.password 
    }
    assert last_response.ok?
    data = JSON.parse(last_response.body)
    token = AuthToken.where(value: data['value']).first
    assert token.active?
  end

  def test_auth_with_token
    user = Factory::Users.make_with_hourly_auth_token!
    post '/login.json', {}, {'AUTH_TOKEN' =>  user.auth_tokens.first.value}
    assert last_response.ok?
  end
end
