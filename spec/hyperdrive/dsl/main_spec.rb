# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::DSL::Main do
  it "creates a singleton instance of hyperdrive" do
    hyperdrive do
    end.must_be_instance_of ::Hyperdrive::DSL::Main
  end

  it "registers a resource" do
    hyperdrive do
      resource(:thing) {}
    end.resources[:thing].must_be_instance_of ::Hyperdrive::Resource
  end
end
