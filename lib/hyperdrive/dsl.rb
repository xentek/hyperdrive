# encoding: utf-8

require 'hyperdrive/dsl/main'
require 'hyperdrive/dsl/resource'

def hyperdrive(&block)
  Hyperdrive::DSL::Main.instance.instance_eval(&block) if block_given?
  Hyperdrive::DSL::Main.instance
end
