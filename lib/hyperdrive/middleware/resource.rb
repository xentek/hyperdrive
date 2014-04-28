# encoding: utf-8

# Internal: Adds the requested resource to rack's env
module Hyperdrive
  module Middleware
    class Resource
      def initialize(app, resource)
        @app = app
        @resource = resource
      end

      def call(env)
        env['hyperdrive.resource'] = @resource
        @app.call(env)
      end
    end
  end
end
