# All other exceptions should extend this one. This exception was made to
# be easy to handle all possible errors on api requests with just one line:
#  rescue_from ApiKits::Exceptions::Generic, :with => :generic_error
class ApiKits::Exceptions::Generic < StandardError
end
