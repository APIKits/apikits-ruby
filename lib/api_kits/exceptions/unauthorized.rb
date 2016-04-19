# Exception for a Unauthorized Response (Status Code: 401).
# The request requires authorization.
class ApiKits::Exceptions::Unauthorized < ApiKits::Exceptions::Generic

  # Initialize a new exception.
  #
  # @return [Unauthorized] a new exception.
  def self.initialize
    super('Authentication Required!')
  end

end
