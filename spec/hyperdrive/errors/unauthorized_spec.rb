# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Errors::Unauthorized do
  before do
    @error = Hyperdrive::Errors::Unauthorized.new
  end

  it "returns a 401 status code" do
    @error.http_status_code.must_equal 401
  end

  it "has a message" do
    @error.message.must_match(/authentication/)
  end
end
