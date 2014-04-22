module Hyperdrive
  module Errors
    class NotFound < HTTPError
      def message
        "The requested resource could not be found."
      end

      def http_status_code
        404
      end
    end
  end
end