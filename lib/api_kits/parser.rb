require 'json'

# ApiKits::Parser provides a method to parse the request response.
module ApiKits::Parser

  # Parse the JSON response.
  #
  # @param [HTTP] response HTTP object for the request.
  # @param [String] url The URL of the request.
  # @return [Hash] the body parsed.
  def self.response(response, url)
    raise_exception(response, url)
    begin
      object = ::JSON.parse(response.body)
    rescue ::JSON::ParserError, TypeError
      object = {}
    end
    object
  end

  protected

  # Check if the response was successful, otherwise raise a proper exception.
  #
  # @param [HTTP] response HTTP object for the request.
  # @param [String] url The url of the request.
  # @raise [ApiKits::Exceptions::Unauthorized] if the response code status is 401
  # @raise [ApiKits::Exceptions::Forbidden] if the response code status is 403
  # @raise [ApiKits::Exceptions::NotFound] if the response code status is 404
  # @raise [ApiKits::Exceptions::InternalServerError] if the response code status is 500
  # @raise [ApiKits::Exceptions::BadGateway] if the response code status is 502
  # @raise [ApiKits::Exceptions::ServiceUnavailable] if the response code status is 503
  def self.raise_exception(response, url)
    case response.code.to_i
    when 401 then raise ApiKits::Exceptions::Unauthorized
    when 403 then raise ApiKits::Exceptions::Forbidden
    when 404 then raise ApiKits::Exceptions::NotFound.new(url)
    when 500 then raise ApiKits::Exceptions::InternalServerError
    when 502 then raise ApiKits::Exceptions::BadGateway
    when 503 then raise ApiKits::Exceptions::ServiceUnavailable
      else return
    end
  end

end
