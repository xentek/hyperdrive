# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Response do
  before do
    @resource = Hyperdrive::Resource.new(:things)
  end

  it "throws an error when the request method is unspported by hyperdrive" do
    proc { Hyperdrive::Response.new('TRACE', @resource) }.must_raise Hyperdrive::Errors::NotImplemented
  end

  it "throws an error when the request method is not allowed" do
    proc { Hyperdrive::Response.new('GET', @resource) }.must_raise Hyperdrive::Errors::MethodNotAllowed
  end
end
