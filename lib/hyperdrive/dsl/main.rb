# encoding: utf-8
require 'singleton'

module Hyperdrive
  module DSL
    class Main
      include Singleton
      attr_reader :resources, :config

      def initialize
        @resources = {}
        @config = default_config
      end

      def cors(options = {})
        options = sanitize_cors_options(options)
        @config[:cors] = config[:cors].merge(options)
      end

      def vendor(vendor)
        @config[:vendor] = vendor
      end

      def media_types(media_types)
        @config[:media_types] = media_types
      end

      def resource(name)
        @resources[name] = Resource.new(name, &Proc.new).resource
      end

      private

      def default_cors_options
        {
          origins: '*',
          allow_headers: '*, Content-Type, Accept, AUTHORIZATION, Cache-Control',
          credentials: true,
          expose_headers: 'Cache-Control, Content-Language, Content-Type, Expires, Last-Modified, Pragma',
          max_age: 86400
        }
      end

      def sanitize_cors_options(options)
        allowed_options = default_cors_options.keys
        Hyperdrive::Utils.sanitize_keys(allowed_options, options)
      end

      def default_config
        {
          cors: default_cors_options
          vendor: 'hyperdrive',
          media_types: %w(hal+json json)
        }
      end
    end
  end
end
