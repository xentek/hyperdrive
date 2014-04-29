# encoding: utf-8

module Hyperdrive
  class Resource
    attr_reader :namespace, :endpoint, :allowed_params, :filters, :request_handlers, :version
    attr_accessor :name, :desc

    def initialize(resource)
      @namespace = resource.to_s.en.plural
      @endpoint = "/#{namespace}"
      @allowed_params = default_allowed_params
      @filters = default_filters
      @request_handlers = default_request_handlers
    end

    def register_param(key, description, options = {})
      options[:required] = [] if options[:required] == false
      options[:required] = default_param_options if options[:required] == true
      options = default_param_options.merge(options)
      @allowed_params[key] = { desc: description }.merge(options)
    end

    def register_filter(key, description, options = {})
      options[:required] = [] if options[:required] == false
      options[:required] = %w(GET HEAD) if options[:required] == true
      options = default_filter_options.merge(options)
      @filters[key] = { desc: description }.merge(options)
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
      allowed_params.key?(param) and allowed_params[param][:required].include?(http_request_method)
    end

    def required_filter?(param, http_request_method)
      filters.key?(param) and filters[param][:required].include?(http_request_method)
    end

    def required?(param, http_request_method)
      required_param?(param, http_request_method) or required_filter?(param, http_request_method)
    end

    private

    def default_allowed_params
      {
        id: { desc: 'Resource Identifier', required: %w(PUT PATCH DELETE) }
      }
    end

    def default_param_options
      { required: %w(POST PUT PATCH) }.freeze
    end

    def default_filters
      {
        id: { desc: 'Resource Identifier', required: []  }
      }
    end

    def default_filter_options
      { required: [] }.freeze
    end

    def default_request_handlers
      { options: { 'v1' => proc { |env| '' } } }
    end
  end
end
