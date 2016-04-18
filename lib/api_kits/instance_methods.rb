module ApiKits

  # This module handles the logic to make an API call and
  # update_attributes the current object with the response.
  module InstanceMethods

    %w(get delete).each do |method|
      class_eval <<-EVAL
        def #{method}(header = {})
          return self if ApiKits.config.mock
          url = "\#{ApiKits.config.api_uri}\#{self.class.resource_path}/\#{id}"
          response = ApiKits::Dispatcher.send('#{method}', url, header)
          update(response, url)
        end
      EVAL
    end

    alias_method :reload, :get
    alias_method :destroy, :delete

    %w(put patch).each do |method|
      class_eval <<-EVAL
        def #{method}(header = {})
          return self if ApiKits.config.mock
          url = "\#{ApiKits.config.api_uri}\#{self.class.resource_path}/\#{id}"
          response = ApiKits::Dispatcher.send('#{method}', url, self.to_hash, header)
          update(response, url)
        end
      EVAL
    end

    alias_method :update_attributes, :put

    # Make a post request and update the object with the response.
    #
    # @param [Hash] header hash with the header options.
    # @return [Base] the object updated.
    def post(header = {})
      return self if ApiKits.config.mock
      url = "#{ApiKits.config.api_uri}#{self.class.resource_path}"
      response = ApiKits::Dispatcher.post(url, self.to_hash, header)
      update(response, url)
    end

    alias_method :create, :post

    # Removes the root node attribute if found.
    #
    # @param [Hash] attributes the hash with attributes.
    # @return [Hash] the hash with attributes without the root node.
    def remove_root(attributes = {})
      attributes = attributes[self.class.root_node.to_sym] if attributes.key?(self.class.root_node.to_sym)
      attributes = attributes[self.class.root_node.to_s] if attributes.key?(self.class.root_node.to_s)
      attributes
    end

    protected

    # Update an object based on a hash of attributes.
    #
    # @param [Response] response request response.
    # @param [String] url the URL of the requisition.
    # @return [Base] the update_attributes object.
    def update(response, url)
      return response if ApiKits.config.hydra
      attributes = ApiKits::Parser.response(response, url)
      hash = remove_root(attributes)
      hash = hash.merge({ 'response' => attributes })
      self.attributes = hash
      self
    end

  end
end
