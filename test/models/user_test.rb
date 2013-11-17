require 'test/test_helper'

class UserTest < MiniTest::Unit::TestCase

  def setup
    @user = Factory::Users.make
  end

  def test_attributes
    attrs = [
      :id,
      :email,
      :password_digest,
      :password,
      :password_confirmation,
      :created_at,
      :updated_at
    ]
    attrs.each do |attr|
      assert @user.respond_to? attr
    end
  end

  def test_associations
    rels = [
      :auth_tokens
    ]
    rels.each do |rel|
      assert @user.respond_to? rel
    end
  end

  def test_validating_email_presence
    assert !user_without_email.valid?
  end

  private
  def user_without_email
    @user.email = nil
    @user
  end

end

