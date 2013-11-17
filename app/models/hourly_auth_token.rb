class HourlyAuthToken < AuthToken

  # @!method before_create_set_expiration
  # @overload before_create :set_expiration
  # A hook that ensures that the {#set_expiration} method is run before 
  #   the {HourlyAuthToken} is created
  before_create :set_expiration

  # Sets {#expires_at} to one hour from now
  def set_expiration
    self.expires_at ||= DateTime.now + (Float(1)/Float(24))
  end
end
