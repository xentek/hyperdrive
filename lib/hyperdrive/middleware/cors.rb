# encoding: utf-8

module Hyperdrive
  module Middleware
    class CORS
      def initialize(app, options = {})
        @app = app
      end

      def call(env)
        status, headers, body = @app.call(env)
        #headers.merge!(cross_origin_headers)
        [status, headers, body]
      end

      private

      def default_cors_options
        {
          
        }
      end

      #def cross_origin_headers
        #{
          #'Access-Control-Allow-Origin' => origin,
          #'Access-Control-Allow-Methods' => methods,
          #'Access-Control-Allow-Headers' => settings.allow_headers,
          #'Access-Control-Allow-Credentials' => settings.allow_credentials.to_s,
          #'Access-Control-Max-Age' => settings.max_age.to_s,
          #'Access-Control-Expose-Headers' => settings.expose_headers.join(', ')
        #}
      #end
    end
  end
end
