# encoding: utf-8
require 'singleton'

module Hyperdrive
  module DSL
    class Main
      include Singleton
      attr_reader :resources

      def initialize(&block)
        @resources = {}
      end

      def resource(name, &block)
        @resources[name] = Resource.new(name, &block).resource
      end
    end
  end
end
