# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Middleware::CORS do
  def app
    inner_app = lambda { |env|
      [200, {'Content-Type' => 'text/plain'}, ['cors okay']]
    }
    Hyperdrive::Middleware::CORS.new(inner_app)
  end

  before do
    get '/'
  end

  it "allows origins" do
    last_response.header['Access-Control-Allow-Origin'].must_equal ''
  end

  it "allows methods" do
    last_response.header['Access-Control-Allow-Methods'].must_equal ''
  end

  it "allows headers" do
    last_response.header['Access-Control-Allow-Headers'].must_equal ''
  end

  it "allows credentials" do
    last_response.header['Access-Control-Allow-Credentials'].must_equal ''
  end

  it "has a max age" do
    last_response.header['Access-Control-Max-Age'].must_equal ''
  end

  it "exposes headers" do
    last_response.header['Access-Control-Expose-Headers'].must_equal ''
  end
end
