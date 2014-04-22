# encoding: utf-8

module Hyperdrive
  class Response
    attr_reader :resource, :env, :http_request_method, :headers

    def initialize(env, resource)
      @resource = resource
      @env = env
      @http_request_method = env['REQUEST_METHOD']
      
      unless request_method_supported?
        raise Errors::NotImplemented.new(http_request_method)
      end
      
      unless resource.request_method_allowed?(http_request_method)
        raise Errors::MethodNotAllowed.new(http_request_method)
      end

      @headers = default_headers
    end

    def response
      @headers.merge({ 'Content-Type' => 'text/plain' })
      status = (http_request_method == 'POST') ? 201 : 200
      ::Rack::Response.new(resource.request_handler(http_request_method).call(env), status, headers).finish
    end

    private

    def default_headers
      {
        'Allow' => resource.allowed_methods
      }
    end

    def request_method_supported?
      Hyperdrive::Values.request_methods_string_map.key?(http_request_method)
    end
  end
end
