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

      def default_config
        {
          vendor: 'hyperdrive',
          media_types: %w(hal+json json)
        }
      end
    end
  end
end
