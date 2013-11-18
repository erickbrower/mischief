require File.expand_path '../../integration_test_helper.rb', __FILE__

class SampleIntegrationTest < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    INTEGRATION_APP
  end

  def setup
    @test_user = Factory::Users.make_with_hourly_auth_token!
  end

  def test_sanity
    post '/api/auth/login.json', {}, { 'AUTH_TOKEN' => @test_user.auth_tokens.first.value }
    assert last_response.ok?
  end
end
