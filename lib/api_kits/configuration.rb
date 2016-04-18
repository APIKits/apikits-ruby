module ApiKits

  # ApiKits::Configuration provides a way to configure ApiKits globally.
  class Configuration

    # Handle a boolean to define when mock the requests.
    #
    # @return [Boolean] boolean used to set mock requests.
    attr_accessor :mock

    # Handle a the hydra object used by typhoeus to make parallel requests.
    #
    # @return [Typhoeus] object that handle parallel requests.
    attr_accessor :hydra

    # The default header for all requests.
    #
    # @return [Hash] all the default header params used by ApiKits.
    attr_reader :header

    # Get the API URI.
    #
    # @return [String] the API URI.
    def api_uri
      raise Exceptions::BadlyConfigured.new if @api_uri.empty? || @api_uri.nil? || @api_uri == '/'
      @api_uri
    end

    # Set the API URI.
    #
    # @param [String] the API URI.
    def api_uri=(api_uri)
      @api_uri = "#{api_uri}/" unless api_uri[api_uri.size - 1, 1] == '/'
      @api_uri
    end

    # Set the default params of header.
    #
    # @param [Hash] header the default header for requests.
    def header=(header = {})
      @header = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }.merge(header)
    end

    # Set a JWT bearer token authorization for all requests.
    #
    # @param [String] token the user JWT token requests.
    def auth(token)
      @header.merge!({ 'Authorization' => "Bearer #{token}" })
    end
  end

end
