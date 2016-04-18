require 'spec_helper'

describe ApiKits::Dispatcher do
  before :each do
    stub_request(:any, 'http://api.example.com/user/5').to_return(:body => 'asd')
  end

  describe '.get' do
    it 'should return the request' do
      ApiKits::Dispatcher.get('http://api.example.com/user/5', {}).body.should == ('asd')
    end
  end

  describe '.post' do
    it 'should return the request' do
      ApiKits::Dispatcher.post('http://api.example.com/user/5', {}, {}).body.should == ('asd')
    end
  end

  describe '.put' do
    it 'should return the request' do
      ApiKits::Dispatcher.put('http://api.example.com/user/5', {}, {}).body.should == ('asd')
    end
  end

  describe '.patch' do
    it 'should return the request' do
      ApiKits::Dispatcher.patch('http://api.example.com/user/5', {}, {}).body.should == ('asd')
    end
  end

  describe '.delete' do
    it 'should return the request' do
      ApiKits::Dispatcher.delete('http://api.example.com/user/5', {}).body.should == ('asd')
    end
  end
end
