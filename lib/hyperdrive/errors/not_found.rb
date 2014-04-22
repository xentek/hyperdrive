module Hyperdrive
  module Errors
    class NotFound < HTTPError
      def message
        "The requested resource could not be found but may be available again in the future."
      end

      def http_status_code
        404
      end
    end
  end
end