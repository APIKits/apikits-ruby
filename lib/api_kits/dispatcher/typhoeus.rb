# ApiKits::Dispatcher::Typhoeus provides methods to make requests using Typhoeus
module ApiKits::Dispatcher::Typhoeus

  # Make a get request and returns it.
  #
  # @param [String] url of the API request.
  # @param [Hash] header attributes of the request.
  # @return [Typhoeus::Request] the response object.
  def self.get(url, header = {})
    ::Typhoeus.get(url, :headers => ApiKits.config.header.merge(header))
  end

  # Make a post request and returns it.
  #
  # @param [String] url of the API request.
  # @param [Hash] args attributes of object.
  # @param [Hash] header attributes of the request.
  # @return [Typhoeus::Request] the response object.
  def self.post(url, args, header = {})
    ::Typhoeus.post(url, :body => args, :headers => ApiKits.config.header.merge(header))
  end

  # Make a put request and returns it.
  #
  # @param [String] url of the API request.
  # @param [Hash] args attributes of object.
  # @param [Hash] header attributes of the request.
  # @return [Typhoeus::Request] the response object.
  def self.put(url, args, header = {})
    ::Typhoeus.put(url, :body => args, :headers => ApiKits.config.header.merge(header))
  end

  # Make a patch request and returns it.
  #
  # @param [String] url of the API request.
  # @param [Hash] args attributes of object.
  # @param [Hash] header attributes of the request.
  # @return [Typhoeus::Request] the response object.
  def self.patch(url, args, header = {})
    ::Typhoeus.patch(url, :body => args, :headers => ApiKits.config.header.merge(header))
  end

  # Make a delete request and returns it.
  #
  # @param [String] url of the API request.
  # @param [Hash] header attributes of the request.
  # @return [Typhoeus::Request] the response object.
  def self.delete(url, header = {})
    ::Typhoeus.delete(url, :headers => ApiKits.config.header.merge(header))
  end

end
