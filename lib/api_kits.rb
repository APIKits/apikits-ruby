# High Level Namespace of the library ApiKits.
module ApiKits

  autoload :Base,            'api_kits/base'
  autoload :ClassMethods,    'api_kits/class_methods'
  autoload :Collection,      'api_kits/collection'
  autoload :Configuration,   'api_kits/configuration'
  autoload :Dispatcher,      'api_kits/dispatcher'
  autoload :Errors,          'api_kits/errors'
  autoload :Exceptions,      'api_kits/exceptions'
  autoload :InstanceMethods, 'api_kits/instance_methods'
  autoload :Parser,          'api_kits/parser'
  autoload :Version,         'api_kits/version'

  # Configures global settings
  #   ApiKits.configure do |config|
  #     config.api_uri = "api.example.com"
  #   end
  # @yield Yield the configuration object
  # @yieldparam block The Configuration object
  # @yieldreturn [ApiKits::Configuration] The Configuration object
  def self.configure(&block)
    yield @config ||= ApiKits::Configuration.new
  end

  # Global settings for ApiKits
  #
  # @return [Hash] configuration attributes
  def self.config
    @config
  end

  # Parallel API requests
  #
  # @yield The requests to be made
  # @yieldparam block A block with request objects
  # @return [False] the value of the Hydra config
  def self.parallel(&block)
    raise Exceptions::NotPossible unless defined?(::Typhoeus)
    config.hydra = ::Typhoeus::Hydra.new
    yield
    config.hydra.run
    config.hydra = false
  end

  # Default Settings
  configure do |config|
    config.api_uri = ''
    config.header  = {}
    config.mock    = false
    config.hydra   = false
  end

end
