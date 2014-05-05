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
        status = e.respond_to?(:http_status_code) ? e.http_status_code : 500
        headers = { 'Content-Type' => 'application/json' }
        [status, headers, [json_error(e)]]
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
