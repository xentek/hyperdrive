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
        options = default_cors_options(env).merge!(@options)
        headers.merge!(options)
        [status, headers, body]
      end

      private

      def default_cors_options(env)
        {
          'Access-Control-Allow-Origin' => '*',
          'Access-Control-Allow-Methods' => env['hyperdrive.resource'].allowed_methods.join(", "),
          'Access-Control-Allow-Headers' => "*, Content-Type, Accept, AUTHORIZATION, Cache-Control",
          'Access-Control-Allow-Credentials' => "true",
          'Access-Control-Max-Age' => 1728000,
          'Access-Control-Expose-Headers' => "Cache-Control, Content-Language, Content-Type, Expires, Last-Modified, Pragma"
        }
      end

      # def cross_origin_headers
      #   {
      #     'Access-Control-Allow-Origin' => origin,
      #     'Access-Control-Allow-Methods' => methods,
      #     'Access-Control-Allow-Headers' => settings.allow_headers,
      #     'Access-Control-Allow-Credentials' => settings.allow_credentials.to_s,
      #     'Access-Control-Max-Age' => settings.max_age.to_s,
      #     'Access-Control-Expose-Headers' => settings.expose_headers.join(', ')
      #   }
      # end
    end
  end
end
