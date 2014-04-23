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
        
        map '/' do
          info = ''
          hyperdrive.resources.each do |type, resource|
            info += %Q({"id":"#{resource.endpoint}","name":"#{resource.name}","desc":"#{resource.desc}","type":"#{type}}")
          end

          run ->(env) {
            [200, { 'Allow' => Hyperdrive::Values.request_methods.join(",") }, ["[#{info}]"]]
          }
        end
        
        hyperdrive.resources.each do |key, resource|
          map resource.endpoint do
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
