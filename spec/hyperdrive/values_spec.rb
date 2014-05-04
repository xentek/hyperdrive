# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Values do
  before do
    @values = Hyperdrive::Values
  end

  it "returns a list of request methods that are definable" do
    @values.definable_request_methods.must_be_kind_of Array
  end

  it "returns a list of request_methods that are supported" do
    @values.supported_request_methods.must_be_kind_of Array
  end

  it "returns a map of request methods to http request methods" do
    @values.request_methods.must_be_kind_of Hash
  end

  it "returns a map of http request methods to request methods" do
    @values.http_request_methods.must_be_kind_of Hash
  end

  it "returns a map of default cors options" do
    @values.default_cors_options.must_be_kind_of Hash
  end

  it "returns a map of default config options" do
    @values.default_cors_options.must_be_kind_of Hash
  end
end
