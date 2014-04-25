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
    @resource.register_request_handler(:get, Proc.new {|env| 'ok' })
    response = Hyperdrive::Response.new({ 'REQUEST_METHOD' => 'GET' }, @resource)
    response.response.first.must_equal 200
  end
end
