# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Param do
  before do
    @param = default_param
  end

  it "has a name" do
    @param.name.must_equal 'id'
  end

  it "has a description" do
    @param.description.must_equal 'Identifier'
  end

  it "returns an array of HTTP methods it's required for" do
    @param.required.must_equal %w(PUT PATCH DELETE)
  end

  it "returns true if the param is required for the given HTTP method" do
    @param.required?('PUT').must_equal true
  end

  it "returns false if the param is not required for the given HTTP method" do
    @param.required?('POST').must_equal false
  end

  it "converts itself as a hash" do
    constraints = { name: 'id', description: 'Identifier', type: 'String', constraints: 'Required for: PUT, PATCH, DELETE. Must be a valid BSON Object ID.' }
    @param.to_hash.must_equal constraints
  end
end
