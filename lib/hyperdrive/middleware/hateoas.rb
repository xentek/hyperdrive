# encoding: utf-8

module Hyperdrive
  module Middleware
    class HATEOAS
      extend Hyperdrive::Values

      def self.call(env)
        if hyperdrive.resources.empty? || env['PATH_INFO'] != '/'
          raise Hyperdrive::Errors::NotFound
        end

        endpoints = hyperdrive.resources.map do |_,resource|
          resource.to_hash
        end

        api = {
                _links: { self: { href: '/' } },
                name: hyperdrive.config[:name],
                description: hyperdrive.config[:description],
                vendor: hyperdrive.config[:vendor],
                resources: endpoints
              }

        media_types = %w(application/hal+json application/json)
        content_type = env['hyperdrive.accept'].best_of(media_types)
        body = if content_type =~ /json$/
                 Oj.dump(api, mode: :compat)
               else
                 raise Hyperdrive::Errors::NotAcceptable.new(env['HTTP_ACCEPT'])
               end

        status = 200
        headers = {}
        headers['Access-Control-Allow-Origin'] = '*'
        headers['Access-Control-Allow-Methods'] = 'GET, HEAD, OPTIONS'
        headers['Allow'] = 'GET, HEAD, OPTIONS'
        headers['Content-Type'] = content_type
        [status, headers, [body]]
      end
    end
  end
end
