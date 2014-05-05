# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Errors::DSL::UnknownArgument do
  it 'has a message' do
    error = Hyperdrive::Errors::DSL::UnknownArgument.new('trace', 'request')
    error.message.must_match(/DSL/)
  end

  it "formats Symbol arguments with a `:'" do
    error = Hyperdrive::Errors::DSL::UnknownArgument.new(:trace, 'request')
    error.message.must_match(/:trace/)
  end
end
