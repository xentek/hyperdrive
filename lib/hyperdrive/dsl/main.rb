# encoding: utf-8
require 'singleton'

module Hyperdrive
  module DSL
    class Main
      include Singleton
      attr_reader :resources, :config

      def initialize
        @resources = {}
        @config = {}
      end
      
      def cors(options = {})
        @config[:cors] = Hyperdrive::Utils.sanitize_keys(allowed_cors_options, options)
      end

      def resource(name)
        @resources[name] = Resource.new(name, &Proc.new).resource
      end

      private

      def allowed_cors_options
        [:origins, :headers, :credentials, :expose, :max_age].freeze
      end
    end
  end
end
