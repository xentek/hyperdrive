# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Response do
  before do
    @resource = Hyperdrive::Resource.new(:things)
    @env = default_rack_env.merge('hyperdrive.resource' => @resource)
  end

  it "throws an error when the request method is unspported by hyperdrive" do
    @env = @env.merge('REQUEST_METHOD' => 'TRACE')
    proc { Hyperdrive::Response.new(@env) }.must_raise Hyperdrive::Errors::NotImplemented
  end

  it "throws an error when the request method is not allowed" do
    proc { Hyperdrive::Response.new(@env) }.must_raise Hyperdrive::Errors::MethodNotAllowed
  end

  it "responds to requests" do
    @resource.register_request_handler(:get, Proc.new {|env| 'ok' })
    @env = @env.merge('hyperdrive.resource' => @resource)
    response = Hyperdrive::Response.new(@env)
    response.response.first.must_equal 200
  end
end
