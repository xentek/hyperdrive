# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Errors::UnknownError do
  before do
    @error = Hyperdrive::Errors::UnknownError.new
  end

  it "returns a 500 status code" do
    @error.http_status_code.must_equal 500
  end

  it "has a message" do
    @error.message.must_match(/Unknown/)
  end
end
