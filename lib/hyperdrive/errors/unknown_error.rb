# encoding: utf-8

module Hyperdrive
  module Errors
    class UnknownError < HTTPError
      def initialize
        @http_status_code = 500
        @message = 'Unknown Error.'
      end
    end
  end
end
