require 'net/http'
require 'api_kits/net/http' unless Net::HTTP.new('').respond_to?(:patch)

# ApiKits::Dispatcher::NetHttp provides methods to make
# requests using the native ruby library 'net/http'
module ApiKits::Dispatcher::NetHttp

  # Make a get request and returns it.
  #
  # @param [String] url of the API request.
  # @param [Hash] header attributes of the request.
  # @return [HTTP] the response object.
  def self.get(url, header = {})
    dispatch(:get, url, { :header => header })
  end

  # Make a post request and returns it.
  #
  # @param [String] url of the API request.
  # @param [Hash] args attributes of object.
  # @param [Hash] header attributes of the request.
  # @return [HTTP] the response object.
  def self.post(url, args, header = {})
    dispatch(:post, url, { :args => args, :header => header })
  end

  # Make a put request and returns it.
  #
  # @param [String] url of the API request.
  # @param [Hash] args attributes of object.
  # @param [Hash] header attributes of the request.
  # @return [HTTP] the response object.
  def self.put(url, args, header = {})
    dispatch(:put, url, { :args => args, :header => header })
  end

  # Make a patch request and returns it.
  #
  # @param [String] url of the API request.
  # @param [Hash] args attributes of object.
  # @param [Hash] header attributes of the request.
  # @return [HTTP] the response object.
  def self.patch(url, args, header = {})
    dispatch(:patch, url, { :args => args, :header => header })
  end

  # Make a delete request and returns it.
  #
  # @param [String] url of the API request.
  # @param [Hash] header attributes of the request.
  # @return [HTTP] the response object.
  def self.delete(url, header = {})
    dispatch(:delete, url, { :header => header })
  end

  protected

  # Handles the common behavior between all the request types.
  #
  # @param [Symbol] method the request type.
  # @param [String] url the path to make the request.
  # @param [Hash] options extra options like the attributes of a post request and custom header params.
  # @return [HTTP] the response object.
  def self.dispatch(method, url, options = {})
    args   = options[:args].to_json if options[:args]
    header = ApiKits.config.header.merge(options[:header])
    uri    = URI(url)
    http   = Net::HTTP.start(uri.host, uri.port)
    begin
      if args
        http.send(method, uri.request_uri, args, header)
      else
        http.send(method, uri.request_uri, header)
      end
    rescue Errno::ECONNREFUSED
      raise ApiKits::Exceptions::ConnectionRefused
    end

  end
end
