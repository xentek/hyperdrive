# encoding: utf-8

module Hyperdrive
  module DSL
    class Resource
      attr_reader :resource
      def initialize(name, &block)
        @resource = ::Hyperdrive::Resource.new(name)
        instance_eval(&block) if block_given?
      end

      def param(*args)
        resource.register_param(*args)
      end

      def filter(*args)
        resource.register_filter(*args)
      end      
    end
  end
end
