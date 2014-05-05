# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Errors::InternalServerError do
  before do
    @error = Hyperdrive::Errors::InternalServerError.new
  end

  it "returns a 500 status code" do
    @error.http_status_code.must_equal 500
  end

  it "has a message" do
    @error.message.must_match(/unexpected/)
  end
end
