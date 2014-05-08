# encoding: utf-8

module Hyperdrive
  module Middleware
    class Error
      include Hyperdrive::Values

      def initialize(app)
        @app = app
      end

      def call(env)
        @app.call(env)
      rescue => e
        headers = { 'Content-Type' => 'application/json' }
        if e.respond_to?(:http_status_code)
          status = e.http_status_code
          body = [json_error(e)]
        else
          env['rack.errors'] << e
          status = 500
          body = json_error(Hyperdrive::Errors::UnknownError.new)
        end
        [status, headers, body]
      end

      private

      def json_error(e)
        MultiJson.dump({
          _links: { root: { href: '/', title: 'API Root' } },
          error: {
            type: "#{e.class.to_s.split('::').last}",
            message: e.message
          }
        })
      end
    end
  end
end
