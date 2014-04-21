# encoding: utf-8

module Hyperdrive
  module DSL
    class Resource
      attr_reader :resource
      def initialize(key, &block)
        @resource = ::Hyperdrive::Resource.new(key)
        instance_eval(&block) if block_given?
      end

      def name(name)
        resource.name = name
      end

      def desc(description)
        resource.desc = description
      end

      def param(*args)
        resource.register_param(*args)
      end

      def filter(*args)
        resource.register_filter(*args)
      end

      def request(method, &block)
        unless definable_request_methods.include? method
          raise Errors::DSL::UnknownArgument.new(method, 'request')
        end
        resource.define_request_handler(method, block)
      end

      private

      def definable_request_methods
        [:get, :post, :put, :patch, :delete].freeze
      end
    end
  end
end
