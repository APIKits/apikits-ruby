# Exception for a Forbidden Response (Status Code: 403).
# The server understood the request, but is refusing to fulfill it.
class ApiKits::Exceptions::Forbidden < ApiKits::Exceptions::Generic

  # Initialize a new exception.
  #
  # @return [Forbidden] a new exception.
  def self.initialize
    super('Forbidden!')
  end

end
