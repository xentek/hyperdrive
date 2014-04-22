module Hyperdrive
  module Errors
    class InternalServerError < HTTPError
      def message
        "The server encountered an unexpected condition which prevented it from fulfilling the request."
      end

      def http_status_code
        500
      end
    end
  end
end