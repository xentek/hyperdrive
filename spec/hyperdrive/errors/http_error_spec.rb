# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Errors::HTTPError do
  before do
    @error = Hyperdrive::Errors::HTTPError.new(500, 'EXAMPLE ERROR')
  end

  it "returns a 500 status code" do
    @error.http_status_code.must_equal 500
  end

  it "has a message" do
    @error.message.must_equal 'EXAMPLE ERROR'
  end
end

