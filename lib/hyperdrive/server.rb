# encoding: utf-8

module Hyperdrive
  class Server
    def self.call(env)
      server.call(env)
    end

    private

    def self.server
      Rack::Builder.new do
        hyperdrive.resources.each do |key, resource|
          map resource.endpoint do
            use Rack::Runtime
            use Rack::Lint
            use Rack::Head
            run ->(env) {
              begin
                Hyperdrive::Response.new(env, resource).response
              rescue Hyperdrive::Errors::HTTPError => error
                [error.http_status_code, { 'Allow' => resource.allowed_methods.join(',') }, [error.message]]
              end
            }
          end
        end
      end.to_app
    end
  end
end
