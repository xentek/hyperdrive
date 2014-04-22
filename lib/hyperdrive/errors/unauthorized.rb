module Hyperdrive
  module Errors
    class Unauthorized < HTTPError
      def message
        "The request requires user authentication."
      end

      def http_status_code
        401
      end
    end
  end
end