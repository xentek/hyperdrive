# encoding: utf-8

require 'spec_helper'

def app
  Rack::Builder.new do
    map '/' do
      @resource = sample_api.resources.values.first
      use Hyperdrive::Middleware::Resource, @resource
      run ->(env) {
        [200, {'Content-Type' => 'text/plain'}, [env['hyperdrive.resource'].name]]
      }
    end
  end
end

describe Hyperdrive::Middleware::Resource do
  it "adds the requested resource to rack's env" do
    get '/'
    last_response.body.must_equal "Thing Resource"
  end
end
