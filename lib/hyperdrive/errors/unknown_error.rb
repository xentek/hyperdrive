# encoding: utf-8

module Hyperdrive
  module Errors
    class UnknownError < HTTPError
      def initialize(message = 'Unknown Error.')
        @http_status_code = 500
        @message = message
      end
    end
  end
end
