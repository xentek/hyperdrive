# encoding: utf-8

module Hyperdrive
  module Middleware
    class Accept
      def initialize(app)
        @app = app
      end

      def call(env)
        env['hyperdrive.accept'] = Rack::Accept::MediaType.new(env['HTTP_ACCEPT'])
        @app.call(env)
      end
    end
  end
end
