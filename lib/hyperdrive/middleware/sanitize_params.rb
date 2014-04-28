# encoding: utf-8

module Hyperdrive
  module Middleware
    class SanitizeParams
      def initialize(app)
        @app = app
      end

      def call(env)
        unless %w(OPTIONS TRACE).include? env['REQUEST_METHOD']
          request = Rack::Request.new(env)
          params = Hyperdrive::Utils.symbolize_keys(request.params)        
          if %w(GET HEAD).include? env['REQUEST_METHOD']
            params_to_keep = env['hyperdrive.resource'].allowed_params.keys
          else
            params_to_keep = env['hyperdrive.resource'].filters.keys
          end
          env['hyperdrive.params'] = Hyperdrive::Utils.sanitize_keys(params_to_keep, params)
        end
        @app.call(env)
      end
    end
  end
end
