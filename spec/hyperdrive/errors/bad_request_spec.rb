# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Errors::BadRequest do
  before do
    @error = Hyperdrive::Errors::BadRequest.new
  end

  it "returns a 400 status code" do
    @error.http_status_code.must_equal 400
  end

  it "has a message" do
    @error.message.must_match(/bad syntax/)
  end
end
