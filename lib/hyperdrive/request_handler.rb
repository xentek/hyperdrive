# encoding: utf-8

module Hyperdrive
  class RequestHandler
    attr_reader :env, :resource, :params, :request
    def initialize(request_method, block)
      @request_method = request_method
      @block = block
    end

    def call(env)
      @env = env
      @resource = env['hyperdrive.resource']
      @params = env['hyperdrive.params']
      @request = Rack::Request.new(env)
      instance_eval(&@block)
    end
  end
end
