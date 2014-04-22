module Hyperdrive
  module Errors
    class MethodNotAllowed < HTTPError
      def initialize(request_method)
        @request_method = request_method
      end

      def message
        "A request was made using a request method (#{@request_method}) not supported by this resource."
      end

      def http_status_code
        405
      end
    end
  end
end
