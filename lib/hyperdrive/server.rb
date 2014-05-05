# encoding: utf-8

module Hyperdrive
  class Server
    def self.call(env)
      server.call(env)
    end

    private

    def self.server
      Rack::Builder.new do
        use Rack::Lint
        use Rack::Runtime
        use Rack::MethodOverride
        use Rack::Head
        use Rack::ConditionalGet
        use Hyperdrive::Middleware::Error
        use Hyperdrive::Middleware::Accept
        use Rack::Deflater
        use Rack::ETag, "max-age=0,private,must-revalidate", "public,max-age=86400,s-maxage=86400"

        map '/' do
          run Hyperdrive::HATEOAS
        end

        hyperdrive.resources.each do |key, resource|
          map resource.endpoint do
            use Hyperdrive::Middleware::Resource, resource
            use Hyperdrive::Middleware::RequestMethod
            use Hyperdrive::Middleware::SanitizeParams
            use Hyperdrive::Middleware::Pagination
            use Hyperdrive::Middleware::RequiredParams
            use Hyperdrive::Middleware::CORS, hyperdrive.config[:cors]
            use Hyperdrive::Middleware::ContentNegotiation
            run Hyperdrive::Endpoint
          end
        end
      end.to_app
    end
  end
end
