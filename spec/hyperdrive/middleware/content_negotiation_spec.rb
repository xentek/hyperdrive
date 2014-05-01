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

  before do
    @resource = Hyperdrive::Resource.new(:thing)
    @resource.register_request_handler(:get, Proc.new { |env| }, 'v1')
    @env = default_rack_env.merge('hyperdrive.resource' => @resource)
  end

  it "returns the best supported media type" do
    get '/', {}, @env
    last_response.body.must_equal 'application/vnd.hyperdrive.things+hal+json'
  end

  it "throws an error if the media type requested is not supported" do
    -> { get '/', {}, @env.merge('HTTP_ACCEPT' => 'application/xml') }.must_raise Hyperdrive::Errors::NotAcceptable
  end
end
