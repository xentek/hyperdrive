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
    hyperdrive_env = {
      'hyperdrive.resource' => sample_api.resources.values.first
    }
    env = default_rack_env.merge(hyperdrive_env)
    status, @headers, body = app.call(env)
  end

  context 'Default CORS options' do
    it "allows origins" do
      @headers['Access-Control-Allow-Origin'].must_equal '*'
    end

    it "allows methods" do
      @headers['Access-Control-Allow-Methods'].must_equal 'OPTIONS'
    end

    it "allows headers" do
      @headers['Access-Control-Allow-Headers'].must_equal '*, Content-Type, Accept, AUTHORIZATION, Cache-Control'
    end

    it "allows credentials" do
      @headers['Access-Control-Allow-Credentials'].must_equal "true"
    end

    it "has a max age" do
      @headers['Access-Control-Max-Age'].must_equal 1728000
    end

    it "exposes headers" do
      @headers['Access-Control-Expose-Headers'].must_equal 'Cache-Control, Content-Language, Content-Type, Expires, Last-Modified, Pragma'
    end
  end

  context 'Custom CORS options' do
    def app
      inner_app = lambda { |env|
        [200, {'Content-Type' => 'text/plain'}, ['cors okay']]
      }
      options = {'Access-Control-Allow-Credentials' => 'false',
                 'Access-Control-Allow-Origin' => 'http://example.com',
                 'Access-Control-Max-Age' => 123,
                 'Access-Control-Expose-Headers' => 'Cache-Control, Content-Language',
                 'Access-Control-Allow-Headers' => '*, Content-Type'}
      Hyperdrive::Middleware::CORS.new(inner_app, options) 
    end

    it "sets custom Origin" do
      @headers['Access-Control-Allow-Origin'].must_equal 'http://example.com'
    end

    it "sets custom Credentials" do
      @headers['Access-Control-Allow-Credentials'].must_equal 'false'
    end

    it "sets custom Max-Age" do
      @headers['Access-Control-Max-Age'].must_equal 123
    end

    it "sets custom Expose-Headers" do
      @headers['Access-Control-Expose-Headers'].must_equal 'Cache-Control, Content-Language'
    end

    it "sets custom Headers" do
      @headers['Access-Control-Allow-Headers'].must_equal '*, Content-Type'
    end


  end
end