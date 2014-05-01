# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::DSL::Main do
  #it "creates a singleton instance of hyperdrive" do
    #hyperdrive do
    #end.must_be_instance_of ::Hyperdrive::DSL::Main
  #end

  #it "has a vendor" do
    #hyperdrive do
      #vendor 'planet-express'
    #end.config[:vendor].must_equal 'planet-express'
  #end

  #it "has media types" do
    #hyperdrive do
      #media_types ['json']
    #end.config[:media_types].must_equal ['json']
  #end

  #it "registers a resource" do
    #hyperdrive do
      #resource(:thing) {}
    #end.resources[:thing].must_be_instance_of ::Hyperdrive::Resource
  #end
  
  context "cors" do
    before do
      @cors = hyperdrive do
        cors({ origins: '*',
               allow_headers: ['Content-Type', 'Origin', 'Accept'],
               test: 'test'})
      end.config[:cors]
    end

    it "can configure cors options" do
      @cors[:allow_headers].must_equal ['Content-Type', 'Origin', 'Accept']
    end

    it "ensures missing options have default values" do
      @cors[:credentials].must_equal true
    end

    it "removes unsupported cors options" do
      @cors.key?(:test).must_equal false
    end
  end
end
