# encoding: utf-8

module Hyperdrive
  module Errors 
    class HTTPError < RuntimeError
      attr_reader :http_status_code, :message
      def initialize(message, http_status_code = 500)
        @message = message
        @http_status_code = http_status_code
      end
    end
  end
end

