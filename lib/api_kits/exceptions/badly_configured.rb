# Exception raised when one of the configured APIs endpoints path is nil.
# This exception make sure the APIs are properly configured.
class ApiKits::Exceptions::BadlyConfigured < StandardError

  # Initialize a new exception.
  #
  # @return [NotConfigured] a new exception.
  def self.initialize
    super("The api_uri is not properly configured!")
  end

end
