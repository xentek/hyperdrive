# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Middleware::CORS do
  def app
    cors_options = {
      origins: '*',
      allow_headers: '*, Content-Type, Accept, AUTHORIZATION, Cache-Control',
      credentials: true,
      expose_headers: 'Cache-Control, Content-Language, Content-Type, Expires, Last-Modified, Pragma',
      max_age: 86400
    }
    inner_app = ->(env) { [200, {}, ['']] }
    Hyperdrive::Middleware::CORS.new(inner_app, cors_options)
  end

  before do
    env = default_rack_env(default_resource)
    get '/', {}, env
    @headers = last_response.headers
  end

  it "allows origins" do
    @headers['Access-Control-Allow-Origin'].must_equal '*'
  end

  it "allows methods" do
    @headers['Access-Control-Allow-Methods'].must_equal 'OPTIONS, GET, HEAD'
  end

  it "allows headers" do
    @headers['Access-Control-Allow-Headers'].must_equal '*, Content-Type, Accept, AUTHORIZATION, Cache-Control'
  end

  it "allows credentials" do
    @headers['Access-Control-Allow-Credentials'].must_equal "true"
  end

  it "has a max age" do
    @headers['Access-Control-Max-Age'].must_equal "86400"
  end

  it "exposes headers" do
    @headers['Access-Control-Expose-Headers'].must_equal 'Cache-Control, Content-Language, Content-Type, Expires, Last-Modified, Pragma'
  end
end
