require 'active_model'

module ApiKits

  # ApiKits::Base provides a way to make easy API requests as well as
  # making possible to use it inside rails.
  # A example implementation:
  #  class Car < ApiKits::Base
  #    attr_accessor :color, :name, :year
  #  end
  # This class will handle Rails forms as well as it works with respond_with.
  class Base
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend  ActiveModel::Naming

    extend  ApiKits::ClassMethods
    include ApiKits::InstanceMethods

    # @return [Integer] the id of the object.
    attr_accessor :id

    # @return [Hash] the request response.
    attr_accessor :response

    # @return [Hash] the errors object.
    attr_reader :errors

    # Initialize an object based on a hash of attributes.
    #
    # @param [Hash] attributes object attributes.
    # @return [Base] the object initialized.
    def initialize(attributes = {})
      @errors = ApiKits::Errors.new(self)
      remove_root(attributes).each do |name, value|
        send("#{name.to_s}=", value)
      end
    end

    # Return if an object is persisted on the database or not.
    #
    # @return [False] always return false.
    def persisted?
      false
    end

    # Get the resource path of the object on the API URL.
    #
    # @return [String] the resource path on the API for this object.
    def self.resource_path
      return self.to_s.gsub('::', '/').downcase.pluralize unless @resource_path
      @resource_path
    end

    # Set the resource path of the object on the API.
    #
    # @param [String] resource_path path string.
    def self.resource_path=(resource_path)
      resource_path = resource_path[1, resource_path.size - 1] if resource_path[0, 1] == '/'
      @resource_path = resource_path
    end

    # Get the Root node name for this Class.
    #
    # @return [String] a string with the root node name for this class.
    def self.root_node
      @root_node.blank? ? self.to_s.split('::').last.underscore : @root_node
    end

    # Set a custom root node name instead of the Class name.
    #
    # @param [String] root_node root node name.
    def self.root_node=(root_node)
      @root_node = root_node
    end

    # Set methods to initialize associated objects.
    #
    # @param [Hash] associations classes.
    def self.associations=(associations = {})
      associations.each do |association, class_name|
        class_eval <<-EVAL
          def #{association.to_s}=(attributes = {})
            return @#{association.to_s} = attributes.map { |attr|
              #{class_name.constantize}.new(attr)
            } if attributes.instance_of?(Array)
            @#{association.to_s} = #{class_name.constantize}.new(attributes)
          end
          def #{association.to_s}
            @#{association.to_s}
          end
        EVAL
      end
    end

    class << self
      alias_method :association=, :associations=
    end

    # Overwrite #attr_acessor method to save instance_variable names.
    #
    # @param [Array] vars instance variables.
    def self.attr_accessor(*vars)
      @attributes ||= []
      @attributes.concat(vars)
      super
    end

    # Return an array with all instance variables set through attr_accessor.
    #
    # @return [Array] instance variables.
    def self.attributes
      @attributes
    end

    # Return a hash with all instance variables set through attr_accessor
    # and its current values.
    #
    # @return [Hash] instance variables and its values.
    def attributes
      self.class.instance_variable_get('@attributes').inject({}) { |hash, attribute|
        hash.merge(attribute.to_sym => self.send("#{attribute}"))
      }
    end

    # Update instance values based on hash
    #
    # @param attr New attributes
    def attributes=(attr = {})
      remove_root(attr).each do |key, value|
        send("#{key}=", value)
      end
    end

    # Return a hash with a root node and all instance variables set through attr_accessor and its current values.
    #
    # @return [Hash] instance variables and its values.
    def to_hash
      { self.class.root_node.to_sym => attributes }
    end

    # Initialize a collection of objects. The collection will be an ApiKits::Collection object.
    # The objects in the collection will be all instances of this (ApiKits::Base) class.
    #
    # @return [Collection] a collection of objects.
    def self.collection
      url = "#{ApiKits.config.api_uri}#{resource_path}"
      attributes = ApiKits::Parser.response(ApiKits::Dispatcher.get(url), url)
      ApiKits::Collection.new(attributes, self)
    end

    class << self
      alias_method :all, :collection
    end

    # Initialize a collection of objects based on search constraints. The collection will
    # be an ApiKits::Collection object.
    # The objects in the collection will be all instances of this (ApiKits::Base) class.
    #
    # @return [Collection] a collection of objects.
    def self.where(constraints = {})
      query = build_query_string(constraints)
      url = "#{ApiKits.config.api_uri}#{resource_path}?#{query}"
      attributes = ApiKits::Parser.response(ApiKits::Dispatcher.get(url), url)
      ApiKits::Collection.new(attributes, self)
    end

    class << self
      alias_method :where, :search
    end


    # Set the hash of errors, making keys symbolic.
    #
    # @param [Hash] errs errors of the object.
    def errors=(errs = {})
      errors.add_errors(Hash[errs.map{ |(key, value)| [key.to_sym,value] }])
    end

    private

    # Return a URL-compatible query string from hash of parameters.
    #
    # @param [Hash] params the hash of key/value parameters.
    # @return [String] the query string.
    def self.build_query_string(params)
      URI.escape(params.collect{ |key, value| "#{key.to_s}=#{value.to_s}"}.join('&'))
    end

  end
end
