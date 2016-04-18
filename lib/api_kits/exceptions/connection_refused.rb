# Exception for a Connection Refused response.
class ApiKits::Exceptions::ConnectionRefused < ApiKits::Exceptions::Generic

  # Initialize a new exception.
  #
  # @return [ConnectionRefused] a new exception.
  def self.initialize
    super('Connection Refused!')
  end

end
