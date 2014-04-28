# encoding: utf-8

require 'spec_helper'

def app
  Rack::Builder.new do
    map '/' do
      @resource = sample_api.resources.values.first
      use Hyperdrive::Middleware::Resource, @resource
      use Hyperdrive::Middleware::SanitizeParams
      run ->(env) {
        [200, {'Content-Type' => 'text/plain'}, [env['hyperdrive.params']]]
      }
    end
  end
end

describe Hyperdrive::Middleware::SanitizeParams do
  context "GET" do
    before do
      get '/', { 'id' => '1001', 'removed' => 'me' }
    end

    it "will sanitize params" do
      last_response.body.must_equal "{:id=>\"1001\"}"
    end
  end

  context "POST" do
    before do
      post '/', { 'id' => '1001', 'removed' => 'me' }
    end

    it "will sanitize params" do
      last_response.body.must_equal "{:id=>\"1001\"}"
    end
  end
end
