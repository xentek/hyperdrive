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
            run lambda { |x| [200, { "Content-Type" => "text/plain" }, ["OK"]] }
          end
        end
      end.to_app
    end
  end
end
