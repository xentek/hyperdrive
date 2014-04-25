# encoding: utf-8
require 'singleton'

module Hyperdrive
  module DSL
    class Main
      include Singleton
      attr_reader :resources

      def initialize
        @resources = {}
      end

      def resource(name)
        @resources[name] = Resource.new(name, &Proc.new).resource
      end
    end
  end
end
