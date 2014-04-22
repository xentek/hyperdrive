module Hyperdrive
  module Errors
    class BadRequest < HTTPError
      def message
        "The request cannot be fulfilled due to bad syntax."
      end

      def http_status_code
        400
      end
    end
  end
end