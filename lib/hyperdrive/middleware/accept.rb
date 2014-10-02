# encoding: utf-8

module Hyperdrive
  module Middleware
    class Accept
      def initialize(app)
        @app = app
      end

      def call(env)
        env['hyperdrive.accept'] = Rack::Accept::MediaType.new(env['HTTP_ACCEPT'])
        env['hyperdrive.accept_charset'] = Rack::Accept::Charset.new(env['HTTP_ACCEPT_CHARSET'])
        @app.call(env)
      end
    end
  end
end
