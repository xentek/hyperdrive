module Hyperdrive
  module Errors
    class MissingRequiredParam < HTTPError
      attr_reader :param, :http_request_method
      def initialize(param, http_request_method)
        @param = param
        @http_request_method = http_request_method
      end

      def message
        "The #{param} param is required by #{http_request_method} requests."
      end

      def http_status_code
        400
      end
    end
  end
end
