require 'rspec'
require 'webmock/rspec'
require 'json'
require 'coveralls'

Coveralls.wear!

require "#{File.dirname(__FILE__)}/../lib/api_kits"

class User < ApiKits::Base
  attr_accessor :a, :b

  validates_presence_of :a
  validates_inclusion_of :a, :in => %w(a A)
end

class Admin < ApiKits::Base
  self.root_node = 'user'

  attr_accessor :a, :b
end

class Post < ApiKits::Base
  self.association = { :writer => 'User' }

  attr_accessor :a
end

class Group < ApiKits::Base
  self.associations = { :members => 'User', :owner => 'Admin' }
end

class InvoiceItem < ApiKits::Base
end

ApiKits.configure do |config|
  config.api_uri = 'http://api.example.com'
end
