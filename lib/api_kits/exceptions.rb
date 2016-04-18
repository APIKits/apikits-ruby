# Namespace for the ApiKits Exceptions.
module ApiKits::Exceptions

  autoload :BadGateway,          'api_kits/exceptions/bad_gateway'
  autoload :BadlyConfigured,     'api_kits/exceptions/badly_configured'
  autoload :ConnectionRefused,   'api_kits/exceptions/connection_refused'
  autoload :Forbidden,           'api_kits/exceptions/forbidden'
  autoload :Generic,             'api_kits/exceptions/generic'
  autoload :InternalServerError, 'api_kits/exceptions/internal_server_error'
  autoload :NotFound,            'api_kits/exceptions/not_found'
  autoload :NotPossible,         'api_kits/exceptions/not_possible'
  autoload :ServiceUnavailable,  'api_kits/exceptions/service_unavailable'
  autoload :Unauthorized,        'api_kits/exceptions/unauthorized'

end
