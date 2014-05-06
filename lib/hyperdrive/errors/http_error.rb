# encoding: utf-8

module Hyperdrive
  module Errors 
    class HTTPError < RuntimeError

      def initialize(http_status_code, message)
        @http_status_code = http_status_code
        @message = message
      end

      def message
        @message
      end

      def http_status_code
        @http_status_code
      end
    end
  end
end

