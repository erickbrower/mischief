require File.expand_path '../../test_helper.rb', __FILE__

class UsersControllerTest < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    Controllers::UsersController
  end

  def setup
    @test_user = Factory::Users.make_with_hourly_auth_token!
  end

  def test_paginate_users
    10.times { Factory::Users.make! }
    get '/?per=5.json', {}, { 'AUTH_TOKEN' => @test_user.auth_tokens.first.value }
    assert last_response.ok?
    user_data = JSON.parse last_response.body
    assert user_data.length == 5
    get '/?page=2&per=5.json', {}, { 'AUTH_TOKEN' => @test_user.auth_tokens.first.value }
    next_user_data = JSON.parse last_response.body
    assert user_data.length == 5
    assert user_data - next_user_data == user_data 
  end

  def test_create_user
    post '/.json', Factory::Users.valid_attrs.to_json, { 'AUTH_TOKEN' => @test_user.auth_tokens.first.value }
    assert last_response.ok?
  end

  def test_update_user
    existing_user = Factory::Users.make!
    existing_user.email = 'testupdate@test.com'
    put "/#{existing_user.id}.json", existing_user.to_json, { 'AUTH_TOKEN' => @test_user.auth_tokens.first.value }
    response_data = JSON.parse last_response.body
    assert !response_data.key?('errors')
    existing_user.reload
    assert existing_user.email = 'testupdate@test.com'
  end

  def test_show_user
    existing_user = Factory::Users.make!
    get "/#{existing_user.id}.json", {}, { 'AUTH_TOKEN' => @test_user.auth_tokens.first.value }
    assert last_response.ok?
    user_data = JSON.parse last_response.body
    assert user_data['email'] == existing_user.email
  end

  def test_delete_user
    existing_user = Factory::Users.make!
    delete "/#{existing_user.id}.json", {}, { 'AUTH_TOKEN' => @test_user.auth_tokens.first.value }
    assert last_response.ok?
    assert_raises ActiveRecord::RecordNotFound do
      User.find existing_user.id
    end
  end
end
