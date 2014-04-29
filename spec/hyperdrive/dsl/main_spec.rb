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

  it "strips off unallowed CORS headers" do
    options = {
                origins: '*', 
                headers: ['Content-Type', 'Origin', 'Accept'], 
                credentials: true,
                expose: ['test'], 
                test: 'test'
              }
    hyperdrive do
      cors(options)
    end.config[:cors].key?(:test).must_equal false
  end

  it "keeps allowed CORS headers" do
    options = { 
                origins: '*',
                headers: ['Content-Type', 'Origin', 'Accept'], 
                credentials: true,
                expose: ['test'],
                test: 'test',
                another_test: 'test'
              }
    hyperdrive do
      cors(options)
    end.config[:cors].keys.must_equal [:origins, :headers, :credentials, :expose]
  end
end