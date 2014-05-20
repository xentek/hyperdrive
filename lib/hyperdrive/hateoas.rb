# encoding: utf-8

module Hyperdrive
  class HATEOAS
    extend Hyperdrive::Values

    def self.call(env)
      @env = env
      if hyperdrive.resources.empty? || env['PATH_INFO'] != '/'
        raise Hyperdrive::Errors::NotFound
      end

      [200, headers, [body]]
    end

    private
  
    def self.endpoints
      hyperdrive.resources.map do |_,resource|
        resource.to_hash
      end
    end

    def self.response
      {
        _links: { self: { href: '/' } },
        name: hyperdrive.config[:name],
        description: hyperdrive.config[:description],
        vendor: hyperdrive.config[:vendor],
        resources: endpoints
      }
    end
    
    def self.body
      if content_type =~ /json$/
        MultiJson.dump(response)
      else
        raise Errors::NotAcceptable.new(@env['HTTP_ACCEPT'])
      end
    end

    def self.media_types
      %w(hal+json json).map do |media_type|
        "application/vnd.#{hyperdrive.config[:vendor]}+#{media_type}"
      end + %w(application/hal+json application/json)
    end

    def self.content_type
      @env['hyperdrive.accept'].best_of(media_types)
    end

    def self.headers
      {
        'Access-Control-Allow-Origin' => '*',
        'Access-Control-Allow-Methods' => 'GET, HEAD, OPTIONS',
        'Allow' => 'GET, HEAD, OPTIONS',
        'Content-Type' => content_type
      }
    end
  end
end
