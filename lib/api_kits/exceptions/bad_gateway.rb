# Exception for a Bad Gateway response (Status Code: 502).
# The server, while acting as a gateway or proxy, received an invalid
# response from the upstream server it accessed in attempting to fulfill the request.
class ApiKits::Exceptions::BadGateway < ApiKits::Exceptions::Generic

  # Initialize a new exception.
  #
  # @return [BadGateway] a new exception.
  def self.initialize
    super('Bad Gateway!')
  end

end
