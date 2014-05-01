# encoding: utf-8

module Hyperdrive
  module Middleware
    class CORS
      def initialize(app, options = {})
        @app = app
        @options = options
      end

      def call(env)
        status, headers, body = @app.call(env)
        cors = cors_headers(env['hyperdrive.resource'].allowed_methods)
        headers.merge!(cors)
        [status, headers, body]
      end

      private

      def cors_headers(allowed_methods = '*')
        {
          'Access-Control-Allow-Origin' => [@options[:origins]].flatten.join(", "),
          'Access-Control-Allow-Methods' => [allowed_methods].flatten.join(", "),
          'Access-Control-Allow-Headers' => [@options[:allow_headers]].flatten.join(", "),
          'Access-Control-Allow-Credentials' => "#{@options[:credentials]}",
          'Access-Control-Max-Age' => @options[:max_age].to_i,
          'Access-Control-Expose-Headers' => [@options[:expose_headers]].flatten.join(", ")
        }
      end
    end
  end
end
