# encoding: utf-8

module Hyperdrive
  class RequestHandler
    attr_reader :env, :resource, :request, :request_method, :params
    def initialize(request_method, block)
      @request_method = request_method
      @block = block
    end

    def call(env, resource)
      @env = env
      @resource = resource
      @request = Rack::Request.new(@env)
      @params = symbolize_keys(@request.params)

      if [:get, :head, :options].include? request_method
        sanitize_filters!
      else
        sanitize_params!
      end

      instance_eval(&@block)
    end

    def sanitize_params!
      @params = sanitize!(resource.allowed_params.keys)
    end

    def sanitize_filters!
      @params = sanitize!(resource.filters.keys)
    end

    def sanitize!(hash)
      Hash[@params.select do |key,value|
       hash.include? key
      end]
    end

    def symbolize_keys(hash)
      hash.inject({}) do |result, (key, value)|
        Hash[
          case key
          when String then key.to_sym
          else key
          end,
          case value
          when Hash then symbolize_keys(value)
          when Array then value.map{ |v| v.is_a?(Hash) ? symbolize_keys(v) : v }
          else value
          end
        ]
      end
    end
  end
end
