# encoding: utf-8

module Hyperdrive
  module Middleware
    class Pagination
      attr_reader :default_per_page
      def initialize(app)
        @app = app
        @default_per_page = hyperdrive.config.fetch(:per_page) { 20 }
      end

      def call(env)
        if %(GET HEAD).include? env['REQUEST_METHOD']
          params = Rack::Request.new(env).params
          env['hyperdrive.page']     = params.delete('page') { 1 }.to_i
          env['hyperdrive.page']     = 1 if env['hyperdrive.page'] < 1
          env['hyperdrive.per_page'] = params.delete('per_page') { default_per_page }.to_i
          env['hyperdrive.per_page'] = default_per_page if env['hyperdrive.per_page'] == 0
        end
        @app.call(env)
      end
    end
  end
end
