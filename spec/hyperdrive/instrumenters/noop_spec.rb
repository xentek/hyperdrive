# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Instrumenters::Noop do
  before do
    @instrumenter = Hyperdrive::Instrumenters::Noop
  end

  it "responds to instrument" do
    @instrumenter.respond_to?(:instrument).must_equal true
  end

  it "returns the result" do
    @instrumenter.instrument('instrumentation', 'measurement').must_equal 'measurement'
  end

  it "optionally takes a block" do
    @instrumenter.instrument('instrumentation', 'measurement') { |payload| payload + '1' } .must_equal 'measurement1'
  end
end
