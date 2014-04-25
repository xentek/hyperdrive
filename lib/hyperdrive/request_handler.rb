# encoding: utf-8

module Hyperdrive
  class RequestHandler
    attr_reader :env, :request, :params
    def initialize(request_method, block)
      @request_method = request_method
      @block = block
    end

    def call(env)
      @env = env
      @request = Rack::Request.new(@env)
      @params = @params = @request.params
      instance_eval(&@block)
    end
  end
end
