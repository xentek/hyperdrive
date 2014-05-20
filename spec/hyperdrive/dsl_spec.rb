# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::DSL do
  before do
    hyperdrive do
      name 'Example'
      description 'Example Description'
      vendor 'example'
      media_types %w(json)
      cors({ origins: '*', allow_headers: %w(Accept), test: 'test'})
      resource(:thing) {}
      per_page '0'
      ssl true
      instrumenter Hyperdrive::Instrumenters::Memory.new
    end
  end

  after do
    hyperdrive.send(:reset!)
  end

  it "has a name" do
    hyperdrive.config[:name].must_equal 'Example'
  end

  it "has a description" do
    hyperdrive.config[:description].must_equal 'Example Description'
  end

  it "has a vendor" do
    hyperdrive.config[:vendor].must_equal 'example'
  end

  it "has media types" do
    hyperdrive.config[:media_types].must_equal ['json']
  end

  it "registers a resource" do
    hyperdrive.resources[:thing].must_be_instance_of ::Hyperdrive::Resource
  end

  it "configures cors options" do
    hyperdrive.config[:cors][:allow_headers].must_equal ['Accept']
  end

  it "ensures missing options have default values" do
    hyperdrive.config[:cors][:credentials].must_equal 'false'
  end

  it "removes unsupported cors options" do
    hyperdrive.config[:cors].key?(:test).must_equal false
  end

  it "configures the default per_page option" do
    hyperdrive.config[:per_page].must_equal 20
  end

  it "configures ssl option" do
    hyperdrive.config[:ssl].must_equal true
  end

  it "configures instrumenter option" do
    hyperdrive.config[:instrumenter].must_be_instance_of Hyperdrive::Instrumenters::Memory
  end

  it "can call the instrumenter" do
    hyperdrive.instrument('instrumentation', 'measurement') { |payload| payload + '1' }
    hyperdrive.config[:instrumenter].events.size.must_be :>, 0
  end
end
