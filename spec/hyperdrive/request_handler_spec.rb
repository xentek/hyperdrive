# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::RequestHandler do
  before do
    @resource = Hyperdrive::Resource.new(:thing)
    @env = default_rack_env.merge('hyperdrive.resource' => @resource, 'hyperdrive.params' => { id: '1001' } )
  end

  it "can access the rack environment" do
    Hyperdrive::RequestHandler.new(:get, Proc.new { env['rack.version'] }).call(@env).must_equal Rack::VERSION
  end

  it "can access the rack request" do
    Hyperdrive::RequestHandler.new(:get, Proc.new { request.env['rack.version'] }).call(@env).must_equal Rack::VERSION
  end

  it "can access the sanitized params" do
    Hyperdrive::RequestHandler.new(:get, Proc.new { params[:id] }).call(@env).must_equal '1001'
  end
end
