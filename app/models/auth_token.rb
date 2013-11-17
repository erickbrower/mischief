require 'securerandom'

class AuthToken < ActiveRecord::Base
  # @!attribute id
  #   @return [Integer] The primary key of the {AuthToken}
  # @!attribute value
  #   @return [String] The {AuthToken}'s value
  # @!attribute user_id
  #   @return [String] The foreign key for the {User} record that this {AuthToken} belongs to
  # @!attribute user
  #   @return [User] The {User} object associated with this {AuthToken}
  # @!attribute expires_at
  #   @return [DateTime] Represents the date and time that the {AuthToken} expires
  # @!attribute created_at
  #   @return [DateTime] Represents the date and time that the {AuthToken} was created
  # @!attribute updated_at
  #   @return [DateTime] Represents the date and time that the {AuthToken} was last updated.

  # @!method belongs_to_user
  # @overload belongs_to :user
  # Establishes an association to the User model such that {AuthToken}s "belong to" a {User}
  belongs_to :user

  # @!method before_validation_generate_value
  # @overload before_validation :generate_value
  # A hook that ensures that the {#generate_value} method is run before any validation occurs
  before_validation :generate_value

  # Generates a unique token for the {AuthToken}'s {#value}
  def generate_value
    unless value
      self.value = SecureRandom.uuid.to_s.gsub(/_/, '')
    end
  end

  # Checks if the {AuthToken} is expired
  #
  # @return [Boolean] True if expired, false if not
  def expired?
    self.expires_at < Time.now.to_datetime
  end

  # Checks if the {AuthToken} is active (opposite of {#expired?})
  #
  # @return [Boolean] True if not expired, false if expired
  def active?
    !self.expired?
  end
end
