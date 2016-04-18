# Exception raised when a parallel requests can't be performed as
# Typhoeus must be defined on the project
class ApiKits::Exceptions::NotPossible < ApiKits::Exceptions::Generic

  # Initialize a new exception.
  #
  # @return [NotPossible] a new exception.
  def self.initialize
    super('Typhoeus must be defined to make parallel requests!')
  end

end
