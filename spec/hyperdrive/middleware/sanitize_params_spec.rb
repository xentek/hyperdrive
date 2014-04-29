# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Middleware::SanitizeParams do
  before do
    @resource = Hyperdrive::Resource.new(:thing)
    @resource.register_filter(:parent_id, '', required: true)
  end

  def app
    Rack::Builder.new do
      map '/' do
        use Hyperdrive::Middleware::SanitizeParams
        run ->(env) {
          [200, {'Content-Type' => 'text/plain'}, [env['hyperdrive.params']]]
        }
      end
    end
  end

  context "GET" do
    before do
      get '/', { 'id' => '1001', 'removed' => 'me' }, default_rack_env.merge('hyperdrive.resource' => @resource)
    end

    it "will sanitize params" do
      last_response.body.must_equal "{:id=>\"1001\"}"
    end
  end

  context "POST" do
    before do
      post '/', { 'id' => '1001', 'removed' => 'me' }, default_rack_env.merge('hyperdrive.resource' => @resource)
    end

    it "will sanitize params" do
      last_response.body.must_equal "{:id=>\"1001\"}"
    end
  end
end
