class User < ActiveRecord::Base
  # @!attribute id
  #   @return [Integer] The primary key of the {User}
  # @!attribute email
  #   @return [String] The email address of the {User}.
  # @!attribute password
  #   @return [String] The plain text password of the {User}, only set when password is being created. Not persisted.
  # @!attribute password_confirmation
  #   @return [String] Used in conjunction with the password field to set a {User}'s password. Not persisted.
  # @!attribute password_digest
  #   @return [String] A bcrypt hash of the {User}'s password.
  # @!attribute created_at
  #   @return [DateTime] A DateTime object representing the date and time that the {User} was created.
  # @!attribute updated_at
  #   @return [DateTime] A DateTime object representing the date and time that the {User} was last updated.
  
  # @!method authenticate(plain_password)
  # Hashes the plain text password argument and determines if it matches the password_digest
  # @param plain_password [String] The plain text password.
  # @return [Boolean] True if the password is valid for the {User}, false if not.
  has_secure_password

  # @!method validate_email_presence
  # @overload validates :email, presence: true
  # Ensures that {#email} has a value before the {User} is persisted
  # @return [Boolean] True if present, false if not.
  # @!visibility private
  validates :email, presence: true

  # @!method validate_password_presence_on_create
  # @overload validates :password, presence: true, on: :create
  # Ensures that the password attribute has a value before the {User}
  #   is created the first time.
  # @return [Boolean] True if present, false if not.
  # @!visibility private
  validates :password, presence: true, on: :create

  # @!method validate_password_confirmation
  # @overload validates :password, presence: true, on: :create
  # Ensures that the password_confirmation attribute has a value before the {User}
  #   is created the first time.
  # @return [Boolean] True if present, false if not.
  # @!visibility private
  validates :password_confirmation, presence: true, on: :create

  # @!method has_many_auth_tokens
  # @overload has_many :auth_tokens
  # Establishes an association to the {AuthToken} model such that a {User} 
  #   "has many" {AuthToken}s
  # @return [Array<ActiveRecord::Relation>] A collection of this {User}s's AuthTokens
  has_many :auth_tokens

end
