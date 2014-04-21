# encoding: utf-8

module Hyperdrive
  class Resource
    attr_reader :endpoint, :allowed_params, :filters, :request_handlers
    attr_accessor :name, :desc

    def initialize(key)
      @key = key
      @endpoint = "/#{@key.to_s.en.plural}"
      @allowed_params = default_allowed_params
      @filters = default_filters
      @request_handlers = {}
    end

    def register_param(key, description, options = {})
      options = default_param_options.merge(options)
      @allowed_params[key] = { desc: description }.merge(options)
    end

    def register_filter(key, description, options = {})
      options = default_filter_options.merge(options)
      @filters[key] = { desc: description }.merge(options)
    end

    def define_request_handler(method, block)
      @request_handlers[method] = block
    end
    
    private

    def default_allowed_params
      {
        id: { desc: 'Resource Identifier', required: %w(PUT PATCH DELETE) }
      }
    end

    def default_param_options
      { required: true }.freeze
    end

    def default_filters
      {
        id: { desc: 'Resource Identifier', required: false }
      }
    end

    def default_filter_options
      { required: false }.freeze
    end
  end
end
