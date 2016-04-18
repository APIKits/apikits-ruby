# ApiKits::Dispatcher provides methods to make requests using Typhoeus
class ApiKits::Dispatcher::Parallel

  # Initialize a new object and save the request in a instance variable.
  #
  # @param [Typhoeus::Request] the request object.
  def initialize(request)
    @request = request
  end

  # When the request finishes, this method updates the given object with the response.
  #
  # @param [ApiKits::Base, ApiKits::Collection] variable the object to update with the response.
  def on_complete_update(variable)
    @request.on_complete do |response|
      attributes = ApiKits::Parser.response(response, response.effective_url)
      if variable.instance_of?(ApiKits::Collection)
        variable.update(attributes)
      else
        variable.attributes = attributes
      end
    end
    ApiKits.config.hydra.queue @request
  end

  %w(get delete).each do |method|
    class_eval <<-EVAL
      def self.#{method}(url, header = {})
        new(::Typhoeus::Request.new(url, :method => '#{method}', :headers => ApiKits.config.header.merge(header)))
      end
    EVAL
  end

  %w(post put patch).each do |method|
    class_eval <<-EVAL
      def self.#{method}(url, args, header = {})
        new(::Typhoeus::Request.new(url, :method => '#{method}', :body => args, :headers => ApiKits.config.header.merge(header)))
      end
    EVAL
  end

end
