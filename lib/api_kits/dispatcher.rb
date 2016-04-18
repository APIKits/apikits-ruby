# ApiKits::Dispatcher provides methods to make requests
module ApiKits::Dispatcher

  autoload :Typhoeus, 'api_kits/dispatcher/typhoeus'
  autoload :NetHttp,  'api_kits/dispatcher/net-http'
  autoload :Parallel, 'api_kits/dispatcher/parallel'

  # It passes the call to a more specific class to handle the dispatch logic based on the environment.
  #
  # @param [Symbol] method_name the name of the method.
  # @param [Array] args array of params to be passed ahead.
  def self.method_missing(method_name, *args)
    case true
    when ApiKits.config.hydra != false && defined?(::Typhoeus) != nil
      return Parallel.send(method_name, *args) if Parallel.respond_to?(method_name)
    when defined?(::Typhoeus)
      return Typhoeus.send(method_name, *args) if Typhoeus.respond_to?(method_name)
    else
      return NetHttp.send(method_name, *args) if NetHttp.respond_to?(method_name)
    end
    super
  end

  # Overwrite respond_to? default behavior
  #
  # @param [Symbol] method_name the name of the method.
  # @param [Boolean] include_private if it does work to private methods as well.
  # @return [Boolean] if it responds to the method or not.
  def self.respond_to_missing?(method_name, include_private = false)
    case true
    when ApiKits.config.hydra && defined?(::Typhoeus)
      return true if Parallel.respond_to?(method_name)
    when defined?(::Typhoeus)
      return true if Typhoeus.respond_to?(method_name)
    else
      return true if NetHttp.respond_to?(method_name)
    end
    super
  end

end
