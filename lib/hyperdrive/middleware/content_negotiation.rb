# encoding: utf-8

module Hyperdrive
  module Middleware
    class ContentNegotiation
      def initialize(app)
        @app = app
      end

      def call(env)
        accept = env['hyperdrive.accept']
        acceptable_content_types = env['hyperdrive.resource'].acceptable_content_types(env['REQUEST_METHOD'])
        env['hyperdrive.media_type'] = accept.best_of(acceptable_content_types)
        raise Hyperdrive::Errors::NotAcceptable.new(env['HTTP_ACCEPT']) unless env['hyperdrive.media_type']
        @app.call(env)
      end
    end
  end
end
