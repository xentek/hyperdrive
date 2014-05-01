# encoding: utf-8

module Hyperdrive
  module Middleware
    class RequestMethod
      def initialize(app)
        @app = app
      end

      def call(env)
        http_request_method = env['REQUEST_METHOD']

        unless request_method_supported?(http_request_method)
          raise Hyperdrive::Errors::NotImplemented.new(http_request_method)
        end

        unless env['hyperdrive.resource'].request_method_allowed?(http_request_method)
          raise Hyperdrive::Errors::MethodNotAllowed.new(http_request_method)
        end

        @app.call(env)
      end

      private
  
      def request_method_supported?(http_request_method)
        Hyperdrive::Values.http_request_methods.key?(http_request_method)
      end
    end
  end
end
