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
      rescue Hyperdrive::Errors::HTTPError => e
        status = e.http_status_code
        headers = { 'Content-Type' => 'application/json',
                    'Allow' => supported_request_methods.join(', ') }
        body = Oj.dump(error_message(e), mode: :compat)
        [status, headers, [body]]
      end

      private
      
      def error_message(e)
        {
          _links: { root: { href: '/', title: 'API Root' } },
          error: { 
            type: "#{e.class.to_s.split('::').last}",
            message: e.message
          }
        }
      end
    end
  end
end
