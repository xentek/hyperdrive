# encoding: utf-8

module Hyperdrive
  module Middleware
    class HATEOAS
      attr_reader :resources
      def initialize(app, resources = {})
        @app = app
        @resources = resources
      end

      def call(env)
        raise Hyperdrive::Errors::NotFound if resources.empty?
        status, headers, body = @app.call(env)

        endpoints = resources.map do |_,resource|
          resource.to_hash
        end

        media_types = %w(application/json)
        content_type = env['hyperdrive.accept'].best_of(media_types)
        body = case content_type
               when 'application/json'
                 Oj.dump(endpoints, mode: :compat)
               when 'application/xml'
                 Ox.dump(endpoints)
               else
                 raise Hyperdrive::Errors::NotAcceptable.new(env['HTTP_ACCEPT'])
               end

        status = 200
        headers['Allow'] = Hyperdrive::Values.supported_request_methods.join(",")
        headers['Content-Type'] = content_type
        [status, headers, [body]]
      end
    end
  end
end
