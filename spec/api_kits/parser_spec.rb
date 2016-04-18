require 'spec_helper'

describe ApiKits::Parser do
  describe '#response' do

    context 'with a valid json response' do
      before :each do
        stub_request(:post, 'http://api.example.com/user/5').to_return(:body => {:base => { :a => :b } }.to_json, :status => '201')
        @response = ApiKits::Dispatcher.post('http://api.example.com/user/5', {}, {})
      end

      it 'should return the response code and the body parsed' do
        ApiKits::Parser.response(@response, 'http://api.example.com/user/5').should == { 'base' => { 'a' => 'b' } }
      end
    end

    context 'with a invalid json response' do
      before :each do
        stub_request(:post, 'http://api.example.com/user/5').to_return(:body => 'wrong', :status => '201')
        @response = ApiKits::Dispatcher.post('http://api.example.com/user/5', {}, {})
      end

      it 'should return the response code and an empty hash' do
        ApiKits::Parser.response(@response, 'http://api.example.com/user/5').should == {}
      end
    end

    context 'with a response code of' do
      context '401' do
        before :each do
          stub_request(:get, 'http://api.example.com/user/5').to_return(:status => 401)
          @response = ApiKits::Dispatcher.get('http://api.example.com/user/5')
        end

        it 'should raise a Unauthorized exception' do
          lambda { ApiKits::Parser.response(@response, 'http://api.example.com/user/5') }.should raise_error(ApiKits::Exceptions::Unauthorized)
        end
      end

      context '403' do
        before :each do
          stub_request(:get, 'http://api.example.com/user/5').to_return(:status => 403)
          @response = ApiKits::Dispatcher.get('http://api.example.com/user/5')
        end

        it 'should raise a Forbidden exception' do
          lambda { ApiKits::Parser.response(@response, 'http://api.example.com/user/5') }.should raise_error(ApiKits::Exceptions::Forbidden)
        end
      end

      context '404' do
        before :each do
          stub_request(:get, 'http://api.example.com/user/5').to_return(:status => 404)
          @response = ApiKits::Dispatcher.get('http://api.example.com/user/5')
        end

        it 'should raise a NotFound exception' do
          lambda { ApiKits::Parser.response(@response, 'http://api.example.com/user/5') }.should raise_error(ApiKits::Exceptions::NotFound, "http://api.example.com/user/5")
        end
      end

      context '500' do
        before :each do
          stub_request(:get, 'http://api.example.com/user/5').to_return(:status => 500)
          @response = ApiKits::Dispatcher.get('http://api.example.com/user/5')
        end

        it 'should raise a InternalServerError exception' do
          lambda { ApiKits::Parser.response(@response, 'http://api.example.com/user/5') }.should raise_error(ApiKits::Exceptions::InternalServerError)
        end
      end

      context '502' do
        before :each do
          stub_request(:get, 'http://api.example.com/user/5').to_return(:status => 502)
          @response = ApiKits::Dispatcher.get('http://api.example.com/user/5')
        end

        it 'should raise a BadGateway exception' do
          lambda { ApiKits::Parser.response(@response, 'http://api.example.com/user/5') }.should raise_error(ApiKits::Exceptions::BadGateway)
        end
      end

      context "503" do
        before :each do
          stub_request(:get, 'http://api.example.com/user/5').to_return(:status => 503)
          @response = ApiKits::Dispatcher.get('http://api.example.com/user/5')
        end

        it 'should raise a ServiceUnavailable exception' do
          lambda { ApiKits::Parser.response(@response, 'http://api.example.com/user/5') }.should raise_error(ApiKits::Exceptions::ServiceUnavailable)
        end
      end

    end
  end
end
