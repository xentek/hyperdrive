# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Errors::NotAcceptable do
  before do
    @error = Hyperdrive::Errors::NotAcceptable.new('application/xml')
  end

  it "returns a 406 status code" do
    @error.http_status_code.must_equal 406
  end

  it "has a message" do
    @error.message.must_match(/xml/)
  end
end
