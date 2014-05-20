# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Filter do
  before do
    @filter = default_filter
  end

  it "has a name" do
    @filter.name.must_equal 'parent_id'
  end

  it "has a description" do
    @filter.description.must_equal 'Parent Identifier'
  end

  it "returns an array of HTTP methods it's required for" do
    @filter.required.must_equal %w(GET HEAD)
  end

  it "returns an array if only a single HTTP method is required" do
    Hyperdrive::Filter.new(:filter, '', required: 'GET').required.must_equal ['GET']
  end

  it "returns true if the param is required for the given HTTP method" do
    @filter.required?('GET').must_equal true
  end

  it "returns false if the param is not required for the given HTTP method" do
    @filter.required?('OPTIONS').must_equal false
  end

  it "converts itself to a hash" do
    constraints = { name: 'parent_id', description: 'Parent Identifier', type: 'String', constraints: 'Required for: GET, HEAD. Must be a valid BSON Object ID.' }
    @filter.to_hash.must_equal constraints
  end
end
