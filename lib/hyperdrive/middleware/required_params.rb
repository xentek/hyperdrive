# encoding: utf-8

module Hyperdrive
  module Middleware
    class RequiredParams
      def initialize(app)
        @app = app
      end

      def call(env)
        @env = env
        if %w(GET HEAD).include? env['REQUEST_METHOD']
          check_required_params(env['hyperdrive.resource'].filters)
        elsif %W(POST PUT PATCH DELETE).include? env['REQUEST_METHOD']
          check_required_params(env['hyperdrive.resource'].params)
        end
        @app.call(env)
      end

      def check_required_params(params)
        params.each do |param, options|
          if @env['hyperdrive.resource'].required?(param, @env['REQUEST_METHOD'])
            if @env['hyperdrive.params'].key?(param)
              if @env['hyperdrive.params'][param] == ''
                raise Errors::MissingRequiredParam.new(param, @env['REQUEST_METHOD'])
              end
            else
              raise Errors::MissingRequiredParam.new(param, @env['REQUEST_METHOD'])
            end
          end
        end
      end
    end
  end
end
