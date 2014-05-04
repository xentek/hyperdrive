# encoding: utf-8

module Hyperdrive
  class Resource
    include Hyperdrive::Values
    attr_reader :id, :namespace, :endpoint, :params, :filters, :request_handlers, :version
    attr_accessor :name, :description

    def initialize(name, hyperdrive_config = hyperdrive.config)
      @namespace = name.to_s.en.plural
      @endpoint = "/#{namespace}"
      @params = default_params
      @filters = default_filters
      @request_handlers = default_request_handlers
      @config = hyperdrive_config
      @id = [@config[:vendor], @namespace].join(':')
    end

    def register_param(param, description, options = {})
      @params[param] = Param.new(param, description, options)
    end

    def register_filter(filter, description, options = {})
      @filters[filter] = Filter.new(filter, description, options)
    end

    def register_request_handler(request_method, request_handler, version = 'v1')
      @request_handlers[request_method] ||= {}
      @request_handlers[request_method].merge!({ version => request_handler })
      if request_method == :get
        @request_handlers[:head] ||= {}
        @request_handlers[:head].merge!({ version => @request_handlers[:get][version] })
      end
    end

    def request_handler(http_request_method, version = nil)
      version ||= latest_version(http_request_method)
      request_method = http_request_methods[http_request_method]
      request_handlers[request_method][version]
    end

    def acceptable_content_types(http_request_method)
      content_types = []
      @config[:media_types].each do |media_type|
        available_versions(http_request_method).each do |version|
          content_types << "application/vnd.#{@config[:vendor]}.#{namespace}.#{version}+#{media_type}"
        end
        content_types << "application/vnd.#{@config[:vendor]}.#{namespace}+#{media_type}"
        content_types << "application/vnd.#{@config[:vendor]}+#{media_type}"
      end
      content_types
    end

    def available_versions(http_request_method)
      request_method = http_request_methods[http_request_method]
      @request_handlers[request_method].keys.sort.reverse
    end

    def latest_version(http_request_method)
      available_versions(http_request_method).first
    end

    def request_method_allowed?(http_request_method)
      allowed_methods.include?(http_request_method)
    end

    def allowed_methods
      request_methods.values_at(*request_handlers.keys)
    end

    def required_param?(param, http_request_method)
      return false if %w(GET HEAD OPTIONS).include? http_request_method
      params.key?(param) and params[param].required?(http_request_method)
    end

    def required_filter?(filter, http_request_method)
      return false unless %w(GET HEAD OPTIONS).include? http_request_method
      filters.key?(filter) and filters[filter].required?(http_request_method)
    end

    def required?(param, http_request_method)
      required_param?(param, http_request_method) or required_filter?(param, http_request_method)
    end

    def to_hash
      {
        _links: { 'self' => { href: endpoint } },
        id: id,
        name: name,
        description: description,
        methods: allowed_methods,
        params: params.map { |_,param| param.to_hash },
        filters: filters.map { |_,filter| filter.to_hash },
        media_types: allowed_methods.map { |method| acceptable_content_types(method) }.uniq
      }
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
