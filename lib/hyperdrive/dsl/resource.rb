# encoding: utf-8

module Hyperdrive
  module DSL
    class Resource
      include Values
      attr_reader :resource
      def initialize(name, hyperdrive_config)
        @resource = ::Hyperdrive::Resource.new(name, hyperdrive_config)
        instance_eval(&Proc.new) if block_given?
      end

      def name(name)
        resource.name = name
      end

      def description(description)
        resource.description = description
      end

      def param(*args)
        resource.register_param(*args)
      end

      def filter(*args)
        resource.register_filter(*args)
      end

      def request(request_method, version = 'v1')
        unless definable_request_methods.include? request_method
          raise Errors::DSL::UnknownArgument.new(request_method, 'request')
        end
        resource.register_request_handler(request_method, Proc.new, version)
      end

      def before(request_methods = [:get, :post, :put, :patch, :delete], version = 'v1')
        Array(request_methods).each do |request_method|
          resource.register_callback(:before, request_method, Proc.new, version)
        end
      end
    end
  end
end
