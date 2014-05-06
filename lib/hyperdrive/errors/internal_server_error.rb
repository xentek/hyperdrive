module Hyperdrive
  module Errors
    class InternalServerError < HTTPError
      def initialize
        @message = 'The server encountered an unexpected condition which prevented it from fulfilling the request.'
        @http_status_code = 500
      end
    end
  end
end
