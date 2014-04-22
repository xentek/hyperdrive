module Hyperdrive
  module Errors
    class NotImplemented < HTTPError
      def initialize(request_method)
        @request_method = request_method
      end

      def message
        "The server either does not recognise the request method (#{@request_method}), or it lacks the ability to fulfill the request."
      end

      def http_status_code
        501
      end
    end
  end
end