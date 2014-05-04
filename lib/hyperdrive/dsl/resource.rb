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

      def request(request_method)
        unless definable_request_methods.include? request_method
          raise Errors::DSL::UnknownArgument.new(request_method, 'request')
        end
        request_handler = Hyperdrive::RequestHandler.new(request_method, Proc.new)
        resource.register_request_handler(request_method, request_handler)
      end
    end
  end
end
