# encoding: utf-8

module Hyperdrive
  class Resource
    attr_reader :namespace, :endpoint, :allowed_params, :filters, :request_handlers, :version
    attr_accessor :name, :desc

    def initialize(resource)
      @namespace = resource.to_s.en.plural
      @endpoint = "/#{namespace}"
      @allowed_params = default_params
      @filters = default_filters
      @request_handlers = default_request_handlers
    end

    def register_param(param, description, options = {})
      @allowed_params[param] = Param.new(param, description, options)
    end

    def register_filter(filter, description, options = {})
      @filters[filter] = Filter.new(filter, description, options)
    end

    def register_request_handler(request_method, request_handler, version = 'v1')
      @request_handlers[request_method] = { version => request_handler }
      if request_method == :get
        @request_handlers[:head] = @request_handlers[:get]
      end
    end

    def request_handler(http_request_method, version = nil)
      version ||= latest_version(http_request_method)
      request_method = Hyperdrive::Values.http_request_methods[http_request_method]
      request_handlers[request_method][version]
    end

    def acceptable_content_types(http_request_method)
      content_types = []
      available_versions(http_request_method).each do |version|
        hyperdrive.config[:media_types].each do |media_type|
          content_types << "application/vnd.#{hyperdrive.config[:vendor]}.#{namespace}.#{version}+#{media_type}"
          content_types << "application/vnd.#{hyperdrive.config[:vendor]}.#{namespace}+#{media_type}"
        end
      end
      content_types
    end

    def available_versions(http_request_method)
      request_method = Hyperdrive::Values.http_request_methods[http_request_method]
      @request_handlers[request_method].keys.sort.reverse
    end

    def latest_version(http_request_method)
      available_versions(http_request_method).first
    end

    def request_method_allowed?(http_request_method)
      allowed_methods.include?(http_request_method)
    end

    def allowed_methods
      Hyperdrive::Values.request_methods.values_at(*request_handlers.keys)
    end

    def required_param?(param, http_request_method)
      allowed_params.key?(param) and allowed_params[param].required?(http_request_method)
    end

    def required_filter?(param, http_request_method)
      filters.key?(param) and filters[param][:required].include?(http_request_method)
    end

    def required?(param, http_request_method)
      required_param?(param, http_request_method) or required_filter?(param, http_request_method)
    end

    private

    def default_params
      {
        id: Param.new(:id, 'Identifier', required: %w(PUT PATCH DELETE))
      }
    end

    def default_filters
      {
        id: Filter.new(:id, 'Resource Identifier', required: false)
      }
    end

    def default_request_handlers
      { options: { 'v1' => proc { |env| '' } } }
    end
  end
end
