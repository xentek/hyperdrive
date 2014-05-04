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
        allowed_methods = '*'
        unless env['hyperdrive.resource'].nil?
          allowed_methods = env['hyperdrive.resource'].allowed_methods
        end
        cors = cors_headers(allowed_methods)
        headers.merge!(cors)
        [status, headers, body]
      end

      private

      def cors_headers(allowed_methods = '*')
        {
          'Access-Control-Allow-Origin'      => Array(@options[:origins]).join(", "),
          'Access-Control-Allow-Methods'     => Array(allowed_methods).join(", "),
          'Access-Control-Allow-Headers'     => Array(@options[:allow_headers]).join(", "),
          'Access-Control-Allow-Credentials' => (@options[:credentials] || false).to_s,
          'Access-Control-Max-Age'           => @options[:max_age].to_i.to_s,
          'Access-Control-Expose-Headers'    => Array(@options[:expose_headers]).join(", ")
        }
      end
    end
  end
end
