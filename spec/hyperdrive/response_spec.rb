# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Response do
  before do
    @resource = Hyperdrive::Resource.new(:things)
  end

  it "throws an error when the request method is unspported by hyperdrive" do
    proc { Hyperdrive::Response.new({ 'REQUEST_METHOD' => 'TRACE' }, @resource) }.must_raise Hyperdrive::Errors::NotImplemented
  end

  it "throws an error when the request method is not allowed" do
    proc { Hyperdrive::Response.new({ 'REQUEST_METHOD' => 'GET' }, @resource) }.must_raise Hyperdrive::Errors::MethodNotAllowed
  end

  it "responds to requests" do
    @resource.define_request_handler(:get, Proc.new { return 'ok' })
    response = Hyperdrive::Response.new({ 'REQUEST_METHOD' => 'GET' }, @resource)
    response.response.must_equal 'ok'
  end
end
