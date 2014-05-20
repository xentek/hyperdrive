# encoding: utf-8

require 'hyperdrive/dsl/resource'

module Hyperdrive
  module DSL
    include Values
    extend self
    attr_reader :config, :resources

    def instance
      @config ||= default_config.dup
      @resources ||= {}
      self
    end

    private

    def name(name)
      @config[:name] = name
    end

    def description(description)
      @config[:description] = description
    end

    def vendor(vendor)
      @config[:vendor] = vendor
    end

    def media_types(media_types)
      @config[:media_types] = media_types
    end

    def cors(options = {})
      allowed_options = default_cors_options.keys
      options = Utils.sanitize_keys(allowed_options, options)
      @config[:cors] = config[:cors].merge(options)
    end

    def per_page(per_page)
      per_page = per_page.to_i
      per_page = default_config[:per_page] if per_page == 0
      @config[:per_page] = per_page
    end

    def ssl(force_ssl)
      @config[:ssl] = force_ssl
    end

    def resource(name)
      @resources[name] = Resource.new(name, @config, &Proc.new).resource
    end

    def reset! # not terribly useful outside of a test environment :(
      @config = default_config.dup
      @resources = {}
    end
  end
end

def hyperdrive(&block)
  Hyperdrive::DSL.instance.instance_eval(&block) if block_given?
  Hyperdrive::DSL.instance
end
