# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Middleware::Resource do
  def app
    inner_app = lambda { |env|
      [200, {'Content-Type' => 'text/plain'}, [env['hyperdrive.resource'].name]]
    }
    Hyperdrive::Middleware::Resource.new(inner_app, sample_api.resources.values.first)
  end

  it "adds the requested resource to rack's env" do
    get '/resource'
    last_response.body.must_equal "Thing Resource"
  end
end
