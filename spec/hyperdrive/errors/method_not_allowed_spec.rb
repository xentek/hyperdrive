# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Errors::MethodNotAllowed do
  before do
    @error = Hyperdrive::Errors::MethodNotAllowed.new('GET')
  end

  it "returns a 405 status code" do
    @error.http_status_code.must_equal 405
  end

  it "has a message" do
    @error.message.must_match(/GET/)
  end
end
