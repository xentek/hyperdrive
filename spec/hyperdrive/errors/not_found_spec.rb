# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Errors::NotFound do
  before do
    @error = Hyperdrive::Errors::NotFound.new
  end

  it "returns a 404 status code" do
    @error.http_status_code.must_equal 404
  end

  it "has a message" do
    @error.message.must_match(/not be found/)
  end
end
