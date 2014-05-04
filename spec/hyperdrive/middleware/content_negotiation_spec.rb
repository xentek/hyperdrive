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
    @resource = default_resource
    @env = default_rack_env(@resource)
  end

  it "returns the best supported media type" do
    get '/', {}, @env
    last_response.body.must_equal 'application/vnd.hyperdrive.things+hal+json'
  end

  it "throws an error if the media type requested is not supported" do
    bad_env = @env.merge('hyperdrive.accept' => Rack::Accept::MediaType.new('application/xml'), 'HTTP_ACCEPT' => 'application/xml')
    -> { get '/', {}, bad_env }.must_raise Hyperdrive::Errors::NotAcceptable
  end
end
