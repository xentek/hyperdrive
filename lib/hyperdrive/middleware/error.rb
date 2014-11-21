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
        error_message = "#{e.class}: #{e.message}"
        $stdout.puts error_message
        $stdout.puts "#{e.backtrace.inspect}"
        headers = { 'Content-Type' => 'application/json' }
        if e.respond_to?(:http_status_code)
          status = e.http_status_code
          body = [json_error(e)]
        else
          status = 500
          error = if ENV['RACK_ENV'] == 'production'
                    Hyperdrive::Errors::UnknownError.new
                  else
                    Hyperdrive::Errors::UnknownError.new(error_message)
                  end
          body = [json_error(error)]
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
