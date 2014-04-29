# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Middleware::Resource do
  before do
    @resource = Hyperdrive::Resource.new(:thing)
  end

  def app
    inner_app = lambda { |env|
      [200, {'Content-Type' => 'text/plain'}, [env['hyperdrive.resource'].namespace]]
    }
    Hyperdrive::Middleware::Resource.new(inner_app, @resource)
  end

  it "adds the requested resource to rack's env" do
    get '/resource'
    last_response.body.must_equal "things"
  end
end
