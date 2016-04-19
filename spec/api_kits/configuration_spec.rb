require 'spec_helper'

describe ApiKits::Configuration do
  describe '#api_uri' do

    context 'when badly configured' do
      before :each do
        ApiKits.configure do |config|
          config.api_uri = ''
        end
      end

      it 'should raise an error' do
        expect { ApiKits.config.api_uri }.to raise_error(ApiKits::Exceptions::BadlyConfigured)
      end
    end

    context 'when properly configured' do
      before :each do
        ApiKits.configure do |config|
          config.api_uri = 'http://api.example.com'
        end
      end

      it 'should return the api_uri value' do
        ApiKits.config.api_uri.should_not be_nil
      end
    end
  end

  describe '#api_uri=' do
    context "with a string without '/'" do
      before :each do
        ApiKits.config.api_uri = 'http://api.example.com'
      end

      it "should set it with a '/'" do
        ApiKits.config.api_uri.should == 'http://api.example.com/'
      end
    end

    context "with a string with '/'" do
      before :each do
        ApiKits.config.api_uri = 'http://api.example.com/'
      end

      it "should set it as passed" do
        ApiKits.config.api_uri.should == 'http://api.example.com/'
      end
    end
  end

  describe '#header' do
    context 'when not configured' do
      it 'should return a hash with configs for content_type only' do
        ApiKits.config.header.should == { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
      end
    end

    context 'when configured' do
      before :each do
        ApiKits.configure do |config|
          config.header = { 'key' => 'value' }
        end
      end

      it 'should return the configs merged' do
        ApiKits.config.header.should == { 'Content-Type' => 'application/json', 'Accept' => 'application/json', 'key' => 'value' }
      end
    end
  end

  describe '#header=' do
    before :each do
      ApiKits.configure do |config|
        config.header = { 'Content-Type' => 'application/xml', 'Accept' => 'application/xml' }
      end
    end

    it 'should merge content_type json with the given hash' do
      ApiKits.config.header.should == { 'Content-Type' => 'application/xml', 'Accept' => 'application/xml' }
    end
  end

  describe '#bearer_token=' do
    before :each do
      ApiKits.configure do |config|
        config.bearer_token('1234567890')
      end
    end

    after :each do
      ApiKits.configure do |config|
        config.header = {}
      end
    end

    it 'should merge token auth in header params' do
      ApiKits.config.header.should == {
        'Content-Type' => 'application/xml',
        'Accept' => 'application/xml',
        'Authorization' => 'Bearer 1234567890'
      }
    end

  end
end
