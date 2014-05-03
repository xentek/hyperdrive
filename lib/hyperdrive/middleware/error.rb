# encoding: utf-8

module Hyperdrive
  module Middleware
    class Error
      def initialize(app)
        @app = app
      end

      def call(env)
        @app.call(env)
      rescue Hyperdrive::Errors::HTTPError => e
        payload = { _links: { root: { href: '/', title: 'API Root' } },
                    error: "#{e.class.to_s.split('::').last}: #{e.message}" }
        
        status = e.http_status_code
        headers = { 'Content-Type' => 'application/hal+json',
                    'Allow' => Hyperdrive::Values.supported_request_methods.join(', ') }
        body = Oj.dump(payload, mode: :compat)
        [status, headers, [body]]
      end
    end
  end
end
