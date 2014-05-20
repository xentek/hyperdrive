# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Instrumenters::Memory do
  before do
    @instrumenter = Hyperdrive::Instrumenters::Memory.new
  end

  it "responds to instrument" do
    @instrumenter.respond_to?(:instrument).must_equal true
  end

  it "returns the result" do
    @instrumenter.instrument('instrumentation', 'measurement').must_equal 'measurement'
  end

  it "yields to the block and returns the result" do
    @instrumenter.instrument('instrumentation', 'measurement') { |payload| payload + '1' }.must_equal 'measurement1'
  end

  it "returns events that have been instrumented" do
    @instrumenter.instrument('instrumentation', 'measurement')
    event = @instrumenter.events.first.to_h
    event.must_equal({ name: 'instrumentation', payload: 'measurement', result: 'measurement' })
  end
end
