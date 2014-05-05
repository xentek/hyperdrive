# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Errors::NotImplemented do
  before do
    @error = Hyperdrive::Errors::NotImplemented.new('TRACE')
  end

  it "returns a 501 status code" do
    @error.http_status_code.must_equal 501
  end

  it "has a message" do
    @error.message.must_match(/TRACE/)
  end
end
