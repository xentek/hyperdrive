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
      @request_handlers = default_request_handlers
    end

    def register_param(key, description, options = {})
      options = default_param_options.merge(options)
      @allowed_params[key] = { desc: description }.merge(options)
    end

    def register_filter(key, description, options = {})
      options = default_filter_options.merge(options)
      @filters[key] = { desc: description }.merge(options)
    end

    def register_request_handler(request_method, request_handler)
      @request_handlers[request_method] = request_handler
      if request_method == :get
        @request_handlers[:head] = request_handler
      end
    end

    def request_handler(http_request_method)
      request_method = Hyperdrive::Values.http_request_methods[http_request_method]
      request_handlers[request_method]
    end

    def request_method_allowed?(http_request_method)
      allowed_methods.include?(http_request_method)
    end

    def allowed_methods
      Hyperdrive::Values.request_methods.values_at(*request_handlers.keys)
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

    def default_request_handlers
      { options: proc { '' } }
    end
  end
end
