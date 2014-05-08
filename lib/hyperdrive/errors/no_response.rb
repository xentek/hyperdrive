# encoding: utf-8

module Hyperdrive
  module Errors
    class NoResponse < HTTPError
      def initialize
        @message = "No response could be generated for this request"
        @http_status_code = 444
      end
    end
  end
end
