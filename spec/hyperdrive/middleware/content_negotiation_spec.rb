# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Middleware::ContentNegotiation do
  def app
    Rack::Builder.new do
      use Hyperdrive::Middleware::ContentNegotiation
      map '/' do
        run ->(env) { [200, {}, ["#{env['hyperdrive.media_type']}"]] }
      end
    end
  end

  it "returns the best supported media type" do
    @resource = Hyperdrive::Resource.new(:thing)
    @resource.register_request_handler(:get, Proc.new { |env| }, 'v1')
    get '/', {}, default_rack_env.merge('hyperdrive.resource' => @resource)
    last_response.body.must_equal 'application/vnd.hyperdrive.things+hal+json'
  end
end
