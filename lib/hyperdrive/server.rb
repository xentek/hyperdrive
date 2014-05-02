# encoding: utf-8

module Hyperdrive
  class Server
    def self.call(env)
      server.call(env)
    end

    private

    def self.server
      Rack::Builder.new do
        use Rack::Runtime
        use Rack::Lint
        use Rack::Head
        use Hyperdrive::Middleware::Accept
        map '/' do
          begin
            inner_app = ->(env) { [404, {}, ['']] }
            run Hyperdrive::Middleware::HATEOAS.new inner_app, hyperdrive.resources
          rescue Hyperdrive::Errors::HTTPError => error
            [error.http_status_code, { 'Allow' => 'GET' }, [error.message]]
          end
        end

        #hyperdrive.resources.each do |key, resource|
          #use Hyperdrive::Middleware::Resource, resource
          #use Hyperdrive::Middleware::RequestMethod
          #use Hyperdrive::Middleware::CORS, hyperdrive.config[:cors]
          #use Hyperdrive::Middleware::SanitizeParams
          #use Hyperdrive::Middleware::RequiredParams
          #map resource.endpoint do
            #run ->(env) {
              #begin
                #Hyperdrive::Response.new(env).response
              #rescue Hyperdrive::Errors::HTTPError => error
                #[error.http_status_code, { 'Allow' => resource.allowed_methods.join(',') }, [error.message]]
              #end
            #}
          #end
        #end
      end.to_app
    end
  end
end
