# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Errors::HTTPError do
  before do
    @error = Hyperdrive::Errors::HTTPError.new("I'M A TEAPOT", 418)
  end

  it "returns a 500 status code" do
    @error.http_status_code.must_equal 418
  end

  it "has a message" do
    @error.message.must_match(/TEAPOT/)
  end
end

