# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::RequestHandler do
  before do
    @env = default_rack_env
  end
  
  it "can access the rack environment" do
    Hyperdrive::RequestHandler.new(:get, Proc.new { env['rack.version'] }).call(@env).must_equal Rack::VERSION
  end

  it "can access the rack request" do
    Hyperdrive::RequestHandler.new(:get, Proc.new { request.env['rack.version'] }).call(@env).must_equal Rack::VERSION
  end  

  it "can access the request params" do
    Hyperdrive::RequestHandler.new(:get, Proc.new { params['okay'] }).call(@env).must_equal 'player'
  end
end
