require 'test/test_helper'

class AuthTokenTest < MiniTest::Unit::TestCase
  def setup
    @auth_token = Factory::AuthTokens.make
  end

  def test_attributes
    assert @auth_token.respond_to? :id
    assert @auth_token.respond_to? :value
    assert @auth_token.respond_to? :user
    assert @auth_token.respond_to? :created_at
    assert @auth_token.respond_to? :updated_at
  end
end
