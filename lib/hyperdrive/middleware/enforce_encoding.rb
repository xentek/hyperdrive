# encoding: utf-8
require 'pry'
module Hyperdrive
  module Middleware
    class EnforceEncoding
      def initialize(app)
        @app = app
      end

      def call(env)
        unless %w(OPTIONS TRACE GET).include? env['REQUEST_METHOD']
          Hyperdrive::Utils.enforce_utf8!(env['hyperdrive.params'])
        end
        @app.call(env)
      end
    end
  end
end
