# encoding: utf-8

module Hyperdrive
  class Endpoint

    def self.call(env)
      @env = env
      @request = Rack::Request.new(@env)
      @media_type = env['hyperdrive.media_type']
      @params = env['hyperdrive.params']
      @resource = env['hyperdrive.resource']
      @headers = Hyperdrive::Values.default_headers.dup
      @headers.merge!('Allow' => resource.allowed_methods.join(', '), 'Content-Type' => @media_type)
      if @resource.has_callback?(:before, env['REQUEST_METHOD'], requested_version)
        instance_eval(&@resource.callback(:before, env['REQUEST_METHOD'], requested_version))
      end
      response.finish
    end

    private

    class << self
      attr_reader   :env, :request, :media_type, :params, :resource
      attr_accessor :headers
    end

    def self.json?
      media_type =~ /json$/
    end

    def self.xml?
      media_type =~ /xml$/
    end

    def self.requested_version
      regex = /.*\/vnd.#{hyperdrive.config[:vendor]}\..*\.(.*)\+.*?\+.*$/
      version = regex.match(media_type)
      return if version.nil?
      version.captures.first
    end

    def self.page
      env['hyperdrive.page']
    end

    def self.per_page
      env['hyperdrive.per_page']
    end

    def self.render(body)
      case body
      when Array, Hash
        if json?
          MultiJson.dump(body)
        else
          env.logger.error "ENDPOINT: Can't serialize response automatically"
          raise Errors::NoResponse.new
        end
      when String
        body
      else
        env.logger.debug "ENDPOINT: Coerceing response to string. Probably not what you want"
        body.to_s
      end
    end

    def self.error(status, message)
      raise Errors::HTTPError.new(message, status)
    end

    def self.status
      case env['REQUEST_METHOD']
      when 'POST'
        201
      when 'DELETE'
        204
      else
        200
      end
    end

    def self.body
      body = instance_eval(&resource.request_handler(env['REQUEST_METHOD'], requested_version))
      body = '' if env['REQUEST_METHOD'] == 'DELETE'
      body
    end

    def self.response
      ::Rack::Response.new(render(body), status, headers)
    end
  end
end
