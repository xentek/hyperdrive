# encoding: utf-8

module Hyperdrive
  module Middleware
    class ParseJSONBody
      def initialize(app)
        @app = app
      end

      def call(env)
        req = Rack::Request.new(env)
        if req.media_type =~ /json$/
          begin
            json_body = MultiJson.load(env['rack.input'].read)
            env["rack.input"].rewind
          rescue => e
            puts "JSONParseError: #{e.message}"
            raise Hyperdrive::Errors::JSONParseError.new
          end
          env['rack.request.form_hash'] ||= {}
          env['rack.request.form_hash'].merge!(json_body)
          env['rack.request.form_input'] = Rack::Utils.build_query(env['rack.request.form_hash'])
          env['rack.input'] = env['rack.request.form_input']
        end
        @app.call(env)
      end
    end
  end
end
