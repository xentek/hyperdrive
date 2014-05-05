# encoding: utf-8

module Hyperdrive
  module Middleware
    class Pagination
      def initialize(app)
        @app = app
      end

      def call(env)
        if %(GET HEAD).include? env['REQUEST_METHOD']
          env['hyperdrive.page'] = env['hyperdrive.params'].delete(:page) { 1 }
          env['hyperdrive.page'] = 1 if env['hyperdrive.page'].to_i < 1
          env['hyperdrive.per_page'] = env['hyperdrive.params'].delete(:per_page) { hyperdrive.config.fetch(:per_page) { 20 } }
          env['hyperdrive.per_page'] = 20 if env['hyperdrive.per_page'].to_i == 0
        end
        @app.call(env)
      end
    end
  end
end
