# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Errors::NoResponse do
  before do
    @error = Hyperdrive::Errors::NoResponse.new
  end

  it "returns a 444 status code" do
    @error.http_status_code.must_equal 444
  end

  it "has a message" do
    @error.message.must_match(/No response/)
  end
end

