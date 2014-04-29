# encoding: utf-8

module Hyperdrive
  module Middleware
    class ContentNegotiation
      def initialize(app)
        @app = app
      end

      def call(env)
        accept = Rack::Accept::MediaType.new(env['HTTP_ACCEPT'])
        acceptable_content_types = env['hyperdrive.resource'].acceptable_content_types(env['REQUEST_METHOD'])
        env['hyperdrive.media_type'] = accept.best_of(acceptable_content_types)
        @app.call(env)
      end
    end
  end
end
