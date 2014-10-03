# encoding: utf-8

module Hyperdrive
  module Middleware
    class Charset
      def initialize(app)
        @app = app
      end

      def call(env)
        unless %w(OPTIONS TRACE).include? env['REQUEST_METHOD']
          charset = Rack::Accept::Charset.new(env['HTTP_ACCEPT_CHARSET'] || 'UTF-8')
          Hyperdrive::Utils.enforce_charset!(charset, env['hyperdrive.params'])
        end
        @app.call(env)
      end
    end
  end
end
